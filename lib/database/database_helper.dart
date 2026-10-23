import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  static const String _databaseName = 'namma_kaimagga.db';
  static const int _databaseVersion = 2;

  // ==========================================================
  // DATABASE
  // ==========================================================

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  // ==========================================================
  // INITIALIZE
  // ==========================================================

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // ==========================================================
  // CREATE DATABASE
  // ==========================================================

  Future<void> _onCreate(Database db, int version) async {
    await _createTables(db);
  }

  // ==========================================================
  // DATABASE UPGRADE
  // ==========================================================

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Remove old Product table.
      await db.execute('DROP TABLE IF EXISTS products');

      // Recreate the survey table using the
      // current Namma Kaimagga structure.
      await db.execute('DROP TABLE IF EXISTS handlooms');

      await db.execute('DROP TABLE IF EXISTS running_id');

      await _createTables(db);
    }
  }

  // ==========================================================
  // CREATE TABLES
  // ==========================================================

  Future<void> _createTables(Database db) async {
    // --------------------------------------------------------
    // HANDLOOM / SURVEY TABLE
    // --------------------------------------------------------

    await db.execute('''
      CREATE TABLE handlooms (
        p1 TEXT PRIMARY KEY,
        p2 TEXT NOT NULL,
        p3 TEXT NOT NULL,
        p4 TEXT NOT NULL,
        p5 TEXT NOT NULL,
        p6 TEXT NOT NULL,
        p7 TEXT NOT NULL,
        p8 TEXT,
        p9 TEXT,
        p10 TEXT,
        p11 TEXT,
        p12 TEXT NOT NULL,
        p13 TEXT NOT NULL,
        p14 TEXT,
        p15 TEXT NOT NULL,
        p16 TEXT,
        p17 TEXT NOT NULL,
        p100 TEXT NOT NULL,
        syncStatus TEXT NOT NULL DEFAULT 'Pending'
      )
    ''');

    // --------------------------------------------------------
    // RUNNING ID TABLE
    // --------------------------------------------------------

    await db.execute('''
      CREATE TABLE running_id (
        id INTEGER PRIMARY KEY CHECK (id = 1),
        lastNumber INTEGER NOT NULL
      )
    ''');

    await db.insert('running_id', {'id': 1, 'lastNumber': 0});
  }

  // ==========================================================
  // GET NEXT RUNNING ID
  // ==========================================================

  Future<int> getNextRunningId() async {
    final db = await database;

    return db.transaction<int>((txn) async {
      final result = await txn.query(
        'running_id',
        where: 'id = ?',
        whereArgs: [1],
        limit: 1,
      );

      int currentNumber = 0;

      if (result.isNotEmpty) {
        currentNumber = (result.first['lastNumber'] as int?) ?? 0;
      }

      final nextNumber = currentNumber + 1;

      await txn.update(
        'running_id',
        {'lastNumber': nextNumber},
        where: 'id = ?',
        whereArgs: [1],
      );

      return nextNumber;
    });
  }

  // ==========================================================
  // INSERT SURVEY
  // ==========================================================

  Future<int> insertSurvey(Map<String, dynamic> data) async {
    final db = await database;

    return db.insert(
      'handlooms',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ==========================================================
  // GET ALL SURVEYS
  // ==========================================================

  Future<List<Map<String, dynamic>>> getAllSurveys() async {
    final db = await database;

    return db.query('handlooms', orderBy: 'p17 DESC');
  }

  // ==========================================================
  // GET SURVEY BY ID
  // ==========================================================

  Future<Map<String, dynamic>?> getSurveyById(String id) async {
    final db = await database;

    final result = await db.query(
      'handlooms',
      where: 'p1 = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }

  // ==========================================================
  // GET PENDING SURVEYS
  // ==========================================================

  Future<List<Map<String, dynamic>>> getPendingSurveys() async {
    final db = await database;

    return db.query(
      'handlooms',
      where: 'syncStatus = ?',
      whereArgs: ['Pending'],
      orderBy: 'p17 DESC',
    );
  }

  // ==========================================================
  // UPDATE SURVEY
  // ==========================================================

  Future<int> updateSurvey(String id, Map<String, dynamic> data) async {
    final db = await database;

    return db.update('handlooms', data, where: 'p1 = ?', whereArgs: [id]);
  }

  // ==========================================================
  // UPDATE SYNC STATUS
  // ==========================================================

  Future<int> updateSyncStatus(String id, String status) async {
    final db = await database;

    return db.update(
      'handlooms',
      {'syncStatus': status},
      where: 'p1 = ?',
      whereArgs: [id],
    );
  }

  // ==========================================================
  // UPDATE SYNCED VERSION
  // ==========================================================

  Future<int> updateSyncedVersion(String id, String version) async {
    final db = await database;

    return db.update(
      'handlooms',
      {'p16': version, 'syncStatus': 'Synced'},
      where: 'p1 = ?',
      whereArgs: [id],
    );
  }

  // ==========================================================
  // DELETE SURVEY
  // ==========================================================

  Future<int> deleteSurvey(String id) async {
    final db = await database;
    final surveyId = id.trim();

    if (surveyId.isEmpty) {
      throw ArgumentError('Cannot delete a survey with an empty P1/Unique ID.');
    }

    return db.transaction<int>((txn) async {
      // Delete child product rows only if this table exists in the installed DB.
      final productTable = await txn.rawQuery(
        "SELECT name FROM sqlite_master WHERE type = 'table' AND name = ?",
        ['products'],
      );

      if (productTable.isNotEmpty) {
        await txn.delete(
          'products',
          where: 'handloomId = ?',
          whereArgs: [surveyId],
        );
      }

      // P1 is the primary key of the locally saved survey.
      return txn.delete(
        'handlooms',
        where: 'TRIM(p1) = ?',
        whereArgs: [surveyId],
      );
    });
  }

  // ==========================================================
  // TOTAL SURVEY COUNT
  // ==========================================================

  Future<int> getSurveyCount() async {
    final db = await database;

    final result = await db.rawQuery('SELECT COUNT(*) as count FROM handlooms');

    return Sqflite.firstIntValue(result) ?? 0;
  }

  // ==========================================================
  // PENDING SURVEY COUNT
  // ==========================================================

  Future<int> getPendingSurveyCount() async {
    final db = await database;

    final result = await db.rawQuery(
      '''
      SELECT COUNT(*) as count
      FROM handlooms
      WHERE syncStatus = ?
      ''',
      ['Pending'],
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  // ==========================================================
  // SYNCED SURVEY COUNT
  // ==========================================================

  Future<int> getSyncedSurveyCount() async {
    final db = await database;

    final result = await db.rawQuery(
      '''
      SELECT COUNT(*) as count
      FROM handlooms
      WHERE syncStatus = ?
      ''',
      ['Synced'],
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  // ==========================================================
  // CLEAR SURVEY DATA
  // ==========================================================

  Future<void> clearSurveyData() async {
    final db = await database;

    await db.transaction((txn) async {
      // Some installed versions may have a legacy child table. Clear it only
      // when it exists, so logout cleanup works across database versions.
      final productTable = await txn.rawQuery(
        "SELECT name FROM sqlite_master WHERE type = 'table' AND name = ?",
        ['products'],
      );
      if (productTable.isNotEmpty) {
        await txn.delete('products');
      }
      await txn.delete('handlooms');
    });
  }

  // ==========================================================
  // CLEAR DATABASE
  // ==========================================================
  //
  // Running ID is intentionally NOT reset.
  // This prevents duplicate Unique IDs.
  //
  // ==========================================================

  Future<void> clearDatabase() async {
    // The running ID is intentionally not reset to avoid duplicate IDs.
    await clearSurveyData();
  }

  // ==========================================================
  // CLOSE DATABASE
  // ==========================================================

  Future<void> closeDatabase() async {
    if (_database == null) {
      return;
    }

    await _database!.close();

    _database = null;
  }
}
