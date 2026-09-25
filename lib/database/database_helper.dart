// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   DatabaseHelper._privateConstructor();

//   static final DatabaseHelper instance =
//       DatabaseHelper._privateConstructor();

//   static Database? _database;

//   // ----------------------------------------------------------
//   // DATABASE
//   // ----------------------------------------------------------

//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }

//     _database = await _initDatabase();

//     return _database!;
//   }

//   // ----------------------------------------------------------
//   // INITIALIZE DATABASE
//   // ----------------------------------------------------------

//   Future<Database> _initDatabase() async {
//     final databasePath = await getDatabasesPath();

//     final path = join(
//       databasePath,
//       'namma_kaimagga.db',
//     );

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }

//   // ----------------------------------------------------------
//   // CREATE TABLES
//   // ----------------------------------------------------------

//   Future<void> _onCreate(
//     Database db,
//     int version,
//   ) async {
//     await db.execute('''
//       CREATE TABLE handlooms (
//         id TEXT PRIMARY KEY,
//         latitude TEXT NOT NULL,
//         longitude TEXT NOT NULL,
//         accuracy TEXT NOT NULL,
//         captureDateTime TEXT NOT NULL,
//         handloomPhoto TEXT,
//         weaverPhoto TEXT,
//         remarks TEXT,
//         syncStatus TEXT NOT NULL
//       )
//     ''');

//     await db.execute('''
//       CREATE TABLE products (
//         id TEXT PRIMARY KEY,
//         handloomId TEXT NOT NULL,
//         productName TEXT NOT NULL,
//         category TEXT NOT NULL,
//         material TEXT,
//         colour TEXT,
//         design TEXT,
//         length REAL,
//         width REAL,
//         weight REAL NOT NULL,
//         quantity INTEGER NOT NULL,
//         price REAL NOT NULL,
//         manufactureDate TEXT,
//         barcode TEXT NOT NULL,
//         imagePath TEXT,
//         remarks TEXT,
//         syncStatus TEXT NOT NULL
//       )
//     ''');
//   }

//   // ----------------------------------------------------------
//   // INSERT HANDLOOM
//   // ----------------------------------------------------------

//   Future<int> insertHandloom(
//     Map<String, dynamic> data,
//   ) async {
//     final db = await database;

//     return await db.insert(
//       'handlooms',
//       data,
//       conflictAlgorithm:
//           ConflictAlgorithm.replace,
//     );
//   }

//   // ----------------------------------------------------------
//   // GET ALL HANDLOOMS
//   // ----------------------------------------------------------

//   Future<List<Map<String, dynamic>>>
//       getAllHandlooms() async {
//     final db = await database;

//     return await db.query(
//       'handlooms',
//       orderBy: 'captureDateTime DESC',
//     );
//   }

//   // ----------------------------------------------------------
//   // GET PENDING HANDLOOMS
//   // ----------------------------------------------------------

//   Future<List<Map<String, dynamic>>>
//       getPendingHandlooms() async {
//     final db = await database;

//     return await db.query(
//       'handlooms',
//       where: 'syncStatus = ?',
//       whereArgs: ['Pending'],
//       orderBy: 'captureDateTime DESC',
//     );
//   }

//   // ----------------------------------------------------------
//   // GET HANDLOOM BY ID
//   // ----------------------------------------------------------

//   Future<Map<String, dynamic>?>
//       getHandloomById(
//     String id,
//   ) async {
//     final db = await database;

//     final result = await db.query(
//       'handlooms',
//       where: 'id = ?',
//       whereArgs: [id],
//       limit: 1,
//     );

//     if (result.isEmpty) {
//       return null;
//     }

//     return result.first;
//   }

//   // ----------------------------------------------------------
//   // UPDATE HANDLOOM
//   // ----------------------------------------------------------

//   Future<int> updateHandloom(
//     String id,
//     Map<String, dynamic> data,
//   ) async {
//     final db = await database;

//     return await db.update(
//       'handlooms',
//       data,
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   // ----------------------------------------------------------
//   // UPDATE SYNC STATUS
//   // ----------------------------------------------------------

//   Future<int> updateHandloomSyncStatus(
//     String id,
//     String status,
//   ) async {
//     final db = await database;

//     return await db.update(
//       'handlooms',
//       {
//         'syncStatus': status,
//       },
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   // ----------------------------------------------------------
//   // DELETE HANDLOOM
//   // ----------------------------------------------------------

//   Future<int> deleteHandloom(
//     String id,
//   ) async {
//     final db = await database;

//     return await db.delete(
//       'handlooms',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   // ==========================================================
//   // PRODUCTS
//   // ==========================================================

//   // ----------------------------------------------------------
//   // INSERT PRODUCT
//   // ----------------------------------------------------------

//   Future<int> insertProduct(
//     Map<String, dynamic> data,
//   ) async {
//     final db = await database;

//     return await db.insert(
//       'products',
//       data,
//       conflictAlgorithm:
//           ConflictAlgorithm.replace,
//     );
//   }

//   // ----------------------------------------------------------
//   // GET ALL PRODUCTS
//   // ----------------------------------------------------------

//   Future<List<Map<String, dynamic>>>
//       getAllProducts() async {
//     final db = await database;

//     return await db.query(
//       'products',
//       orderBy: 'id DESC',
//     );
//   }

//   // ----------------------------------------------------------
//   // GET PRODUCTS FOR HANDLOOM
//   // ----------------------------------------------------------

//   Future<List<Map<String, dynamic>>>
//       getProductsByHandloomId(
//     String handloomId,
//   ) async {
//     final db = await database;

//     return await db.query(
//       'products',
//       where: 'handloomId = ?',
//       whereArgs: [handloomId],
//       orderBy: 'id DESC',
//     );
//   }

//   // ----------------------------------------------------------
//   // GET PENDING PRODUCTS
//   // ----------------------------------------------------------

//   Future<List<Map<String, dynamic>>>
//       getPendingProducts() async {
//     final db = await database;

//     return await db.query(
//       'products',
//       where: 'syncStatus = ?',
//       whereArgs: ['Pending'],
//       orderBy: 'id DESC',
//     );
//   }

//   // ----------------------------------------------------------
//   // GET PRODUCT BY ID
//   // ----------------------------------------------------------

//   Future<Map<String, dynamic>?>
//       getProductById(
//     String id,
//   ) async {
//     final db = await database;

//     final result = await db.query(
//       'products',
//       where: 'id = ?',
//       whereArgs: [id],
//       limit: 1,
//     );

//     if (result.isEmpty) {
//       return null;
//     }

//     return result.first;
//   }

//   // ----------------------------------------------------------
//   // UPDATE PRODUCT
//   // ----------------------------------------------------------

//   Future<int> updateProduct(
//     String id,
//     Map<String, dynamic> data,
//   ) async {
//     final db = await database;

//     return await db.update(
//       'products',
//       data,
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   // ----------------------------------------------------------
//   // UPDATE PRODUCT SYNC STATUS
//   // ----------------------------------------------------------

//   Future<int> updateProductSyncStatus(
//     String id,
//     String status,
//   ) async {
//     final db = await database;

//     return await db.update(
//       'products',
//       {
//         'syncStatus': status,
//       },
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   // ----------------------------------------------------------
//   // DELETE PRODUCT
//   // ----------------------------------------------------------

//   Future<int> deleteProduct(
//     String id,
//   ) async {
//     final db = await database;

//     return await db.delete(
//       'products',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   // ----------------------------------------------------------
//   // DELETE PRODUCTS OF HANDLOOM
//   // ----------------------------------------------------------

//   Future<int> deleteProductsByHandloomId(
//     String handloomId,
//   ) async {
//     final db = await database;

//     return await db.delete(
//       'products',
//       where: 'handloomId = ?',
//       whereArgs: [handloomId],
//     );
//   }

//   // ----------------------------------------------------------
//   // COUNT HANDLOOMS
//   // ----------------------------------------------------------

//   Future<int> getHandloomCount() async {
//     final db = await database;

//     final result = await db.rawQuery(
//       'SELECT COUNT(*) as count FROM handlooms',
//     );

//     return Sqflite.firstIntValue(result) ?? 0;
//   }

//   // ----------------------------------------------------------
//   // COUNT PENDING HANDLOOMS
//   // ----------------------------------------------------------

//   Future<int> getPendingHandloomCount() async {
//     final db = await database;

//     final result = await db.rawQuery(
//       '''
//       SELECT COUNT(*) as count
//       FROM handlooms
//       WHERE syncStatus = ?
//       ''',
//       ['Pending'],
//     );

//     return Sqflite.firstIntValue(result) ?? 0;
//   }

//   // ----------------------------------------------------------
//   // COUNT PRODUCTS
//   // ----------------------------------------------------------

//   Future<int> getProductCount() async {
//     final db = await database;

//     final result = await db.rawQuery(
//       'SELECT COUNT(*) as count FROM products',
//     );

//     return Sqflite.firstIntValue(result) ?? 0;
//   }

//   // ----------------------------------------------------------
//   // CLEAR DATABASE
//   // ----------------------------------------------------------

//   Future<void> clearDatabase() async {
//     final db = await database;

//     await db.delete('products');

//     await db.delete('handlooms');
//   }

//   // ----------------------------------------------------------
//   // CLOSE DATABASE
//   // ----------------------------------------------------------

//   Future<void> closeDatabase() async {
//     final db = await database;

//     await db.close();

//     _database = null;
//   }
// }


// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   DatabaseHelper._privateConstructor();

//   static final DatabaseHelper instance =
//       DatabaseHelper._privateConstructor();

//   static Database? _database;

//   static const String _databaseName = 'namma_kaimagga.db';
//   static const int _databaseVersion = 2;

//   // ==========================================================
//   // DATABASE
//   // ==========================================================

//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }

//     _database = await _initDatabase();

//     return _database!;
//   }

//   // ==========================================================
//   // INITIALIZE
//   // ==========================================================

//   Future<Database> _initDatabase() async {
//     final databasePath = await getDatabasesPath();

//     final path = join(
//       databasePath,
//       _databaseName,
//     );

//     return openDatabase(
//       path,
//       version: _databaseVersion,
//       onCreate: _onCreate,
//       onUpgrade: _onUpgrade,
//     );
//   }

//   // ==========================================================
//   // CREATE
//   // ==========================================================

//   Future<void> _onCreate(
//     Database db,
//     int version,
//   ) async {
//     await _createTables(db);
//   }

//   // ==========================================================
//   // UPGRADE
//   // ==========================================================

//   Future<void> _onUpgrade(
//     Database db,
//     int oldVersion,
//     int newVersion,
//   ) async {
//     if (oldVersion < 2) {
//       await db.execute('DROP TABLE IF EXISTS products');
//       await db.execute('DROP TABLE IF EXISTS handlooms');

//       await _createTables(db);
//     }
//   }

//   // ==========================================================
//   // TABLES
//   // ==========================================================

//   Future<void> _createTables(Database db) async {
//     // --------------------------------------------------------
//     // SURVEY / HANDLOOM TABLE
//     // --------------------------------------------------------

//     await db.execute('''
//       CREATE TABLE handlooms (
//         p1 TEXT PRIMARY KEY,
//         p2 TEXT NOT NULL,
//         p3 TEXT NOT NULL,
//         p4 TEXT NOT NULL,
//         p5 TEXT NOT NULL,
//         p6 TEXT NOT NULL,
//         p7 TEXT NOT NULL,
//         p8 TEXT,
//         p9 TEXT,
//         p10 TEXT,
//         p11 TEXT,
//         p12 TEXT NOT NULL,
//         p13 TEXT NOT NULL,
//         p14 TEXT,
//         p15 TEXT NOT NULL,
//         p16 TEXT,
//         p17 TEXT NOT NULL,
//         p100 TEXT NOT NULL,
//         syncStatus TEXT NOT NULL DEFAULT 'Pending'
//       )
//     ''');

//     // --------------------------------------------------------
//     // PRODUCT TABLE
//     // --------------------------------------------------------

//     await db.execute('''
//       CREATE TABLE products (
//         id TEXT PRIMARY KEY,
//         handloomId TEXT NOT NULL,
//         productName TEXT NOT NULL,
//         category TEXT NOT NULL,
//         material TEXT,
//         colour TEXT,
//         design TEXT,
//         length REAL,
//         width REAL,
//         weight REAL NOT NULL,
//         quantity INTEGER NOT NULL,
//         price REAL NOT NULL,
//         manufactureDate TEXT,
//         barcode TEXT NOT NULL,
//         imagePath TEXT,
//         remarks TEXT,
//         syncStatus TEXT NOT NULL DEFAULT 'Pending'
//       )
//     ''');

//     // --------------------------------------------------------
//     // RUNNING ID TABLE
//     // --------------------------------------------------------

//     await db.execute('''
//       CREATE TABLE running_id (
//         id INTEGER PRIMARY KEY CHECK (id = 1),
//         lastNumber INTEGER NOT NULL
//       )
//     ''');

//     await db.insert(
//       'running_id',
//       {
//         'id': 1,
//         'lastNumber': 0,
//       },
//     );
//   }

//   // ==========================================================
//   // GET NEXT RUNNING ID
//   // ==========================================================

//   Future<int> getNextRunningId() async {
//     final db = await database;

//     return db.transaction<int>((txn) async {
//       final result = await txn.query(
//         'running_id',
//         where: 'id = ?',
//         whereArgs: [1],
//         limit: 1,
//       );

//       int currentNumber = 0;

//       if (result.isNotEmpty) {
//         currentNumber =
//             (result.first['lastNumber'] as int?) ?? 0;
//       }

//       final nextNumber = currentNumber + 1;

//       await txn.update(
//         'running_id',
//         {
//           'lastNumber': nextNumber,
//         },
//         where: 'id = ?',
//         whereArgs: [1],
//       );

//       return nextNumber;
//     });
//   }

//   // ==========================================================
//   // INSERT COMPLETE SURVEY
//   // ==========================================================

//   Future<void> insertCompleteSurvey({
//     required Map<String, dynamic> handloom,
//     required List<Map<String, dynamic>> products,
//   }) async {
//     final db = await database;

//     await db.transaction((txn) async {
//       await txn.insert(
//         'handlooms',
//         handloom,
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );

//       for (final product in products) {
//         await txn.insert(
//           'products',
//           product,
//           conflictAlgorithm: ConflictAlgorithm.replace,
//         );
//       }
//     });
//   }

//   // ==========================================================
//   // HANDLOOM
//   // ==========================================================

//   Future<int> insertHandloom(
//     Map<String, dynamic> data,
//   ) async {
//     final db = await database;

//     return db.insert(
//       'handlooms',
//       data,
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<List<Map<String, dynamic>>> getAllHandlooms() async {
//     final db = await database;

//     return db.query(
//       'handlooms',
//       orderBy: 'p17 DESC',
//     );
//   }

//   Future<List<Map<String, dynamic>>> getPendingHandlooms() async {
//     final db = await database;

//     return db.query(
//       'handlooms',
//       where: 'syncStatus = ?',
//       whereArgs: ['Pending'],
//       orderBy: 'p17 DESC',
//     );
//   }

//   Future<Map<String, dynamic>?> getHandloomById(
//     String id,
//   ) async {
//     final db = await database;

//     final result = await db.query(
//       'handlooms',
//       where: 'p1 = ?',
//       whereArgs: [id],
//       limit: 1,
//     );

//     if (result.isEmpty) {
//       return null;
//     }

//     return result.first;
//   }

//   Future<int> updateHandloom(
//     String id,
//     Map<String, dynamic> data,
//   ) async {
//     final db = await database;

//     return db.update(
//       'handlooms',
//       data,
//       where: 'p1 = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<int> updateHandloomSyncStatus(
//     String id,
//     String status,
//   ) async {
//     final db = await database;

//     return db.update(
//       'handlooms',
//       {
//         'syncStatus': status,
//       },
//       where: 'p1 = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<int> deleteHandloom(
//     String id,
//   ) async {
//     final db = await database;

//     await db.delete(
//       'products',
//       where: 'handloomId = ?',
//       whereArgs: [id],
//     );

//     return db.delete(
//       'handlooms',
//       where: 'p1 = ?',
//       whereArgs: [id],
//     );
//   }

//   // ==========================================================
//   // PRODUCTS
//   // ==========================================================

//   Future<int> insertProduct(
//     Map<String, dynamic> data,
//   ) async {
//     final db = await database;

//     return db.insert(
//       'products',
//       data,
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<List<Map<String, dynamic>>> getAllProducts() async {
//     final db = await database;

//     return db.query(
//       'products',
//       orderBy: 'id DESC',
//     );
//   }

//   Future<List<Map<String, dynamic>>> getProductsByHandloomId(
//     String handloomId,
//   ) async {
//     final db = await database;

//     return db.query(
//       'products',
//       where: 'handloomId = ?',
//       whereArgs: [handloomId],
//       orderBy: 'id DESC',
//     );
//   }

//   Future<List<Map<String, dynamic>>> getPendingProducts() async {
//     final db = await database;

//     return db.query(
//       'products',
//       where: 'syncStatus = ?',
//       whereArgs: ['Pending'],
//       orderBy: 'id DESC',
//     );
//   }

//   Future<int> updateProduct(
//     String id,
//     Map<String, dynamic> data,
//   ) async {
//     final db = await database;

//     return db.update(
//       'products',
//       data,
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<int> updateProductSyncStatus(
//     String id,
//     String status,
//   ) async {
//     final db = await database;

//     return db.update(
//       'products',
//       {
//         'syncStatus': status,
//       },
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<int> deleteProduct(
//     String id,
//   ) async {
//     final db = await database;

//     return db.delete(
//       'products',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<int> deleteProductsByHandloomId(
//     String handloomId,
//   ) async {
//     final db = await database;

//     return db.delete(
//       'products',
//       where: 'handloomId = ?',
//       whereArgs: [handloomId],
//     );
//   }

//   // ==========================================================
//   // COUNTS
//   // ==========================================================

//   Future<int> getHandloomCount() async {
//     final db = await database;

//     final result = await db.rawQuery(
//       'SELECT COUNT(*) as count FROM handlooms',
//     );

//     return Sqflite.firstIntValue(result) ?? 0;
//   }

//   Future<int> getPendingHandloomCount() async {
//     final db = await database;

//     final result = await db.rawQuery(
//       '''
//       SELECT COUNT(*) as count
//       FROM handlooms
//       WHERE syncStatus = ?
//       ''',
//       ['Pending'],
//     );

//     return Sqflite.firstIntValue(result) ?? 0;
//   }

//   Future<int> getProductCount() async {
//     final db = await database;

//     final result = await db.rawQuery(
//       'SELECT COUNT(*) as count FROM products',
//     );

//     return Sqflite.firstIntValue(result) ?? 0;
//   }

//   // ==========================================================
//   // CLEAR
//   // ==========================================================

//   Future<void> clearDatabase() async {
//     final db = await database;

//     await db.delete('products');
//     await db.delete('handlooms');

//     await db.update(
//       'running_id',
//       {'lastNumber': 0},
//       where: 'id = ?',
//       whereArgs: [1],
//     );
//   }

//   // ==========================================================
//   // CLOSE
//   // ==========================================================

//   Future<void> closeDatabase() async {
//     final db = await database;

//     await db.close();

//     _database = null;
//   }
// }

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance =
      DatabaseHelper._privateConstructor();

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

    final path = join(
      databasePath,
      _databaseName,
    );

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

  Future<void> _onCreate(
    Database db,
    int version,
  ) async {
    await _createTables(db);
  }

  // ==========================================================
  // DATABASE UPGRADE
  // ==========================================================

  Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      // Remove old Product table.
      await db.execute(
        'DROP TABLE IF EXISTS products',
      );

      // Recreate the survey table using the
      // current Namma Kaimagga structure.
      await db.execute(
        'DROP TABLE IF EXISTS handlooms',
      );

      await db.execute(
        'DROP TABLE IF EXISTS running_id',
      );

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

    await db.insert(
      'running_id',
      {
        'id': 1,
        'lastNumber': 0,
      },
    );
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
        currentNumber =
            (result.first['lastNumber'] as int?) ?? 0;
      }

      final nextNumber = currentNumber + 1;

      await txn.update(
        'running_id',
        {
          'lastNumber': nextNumber,
        },
        where: 'id = ?',
        whereArgs: [1],
      );

      return nextNumber;
    });
  }

  // ==========================================================
  // INSERT SURVEY
  // ==========================================================

  Future<int> insertSurvey(
    Map<String, dynamic> data,
  ) async {
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

    return db.query(
      'handlooms',
      orderBy: 'p17 DESC',
    );
  }

  // ==========================================================
  // GET SURVEY BY ID
  // ==========================================================

  Future<Map<String, dynamic>?> getSurveyById(
    String id,
  ) async {
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

  Future<int> updateSurvey(
    String id,
    Map<String, dynamic> data,
  ) async {
    final db = await database;

    return db.update(
      'handlooms',
      data,
      where: 'p1 = ?',
      whereArgs: [id],
    );
  }

  // ==========================================================
  // UPDATE SYNC STATUS
  // ==========================================================

  Future<int> updateSyncStatus(
    String id,
    String status,
  ) async {
    final db = await database;

    return db.update(
      'handlooms',
      {
        'syncStatus': status,
      },
      where: 'p1 = ?',
      whereArgs: [id],
    );
  }

  // ==========================================================
  // UPDATE SYNCED VERSION
  // ==========================================================

  Future<int> updateSyncedVersion(
    String id,
    String version,
  ) async {
    final db = await database;

    return db.update(
      'handlooms',
      {
        'p16': version,
        'syncStatus': 'Synced',
      },
      where: 'p1 = ?',
      whereArgs: [id],
    );
  }

  // ==========================================================
  // DELETE SURVEY
  // ==========================================================

  Future<int> deleteSurvey(
    String id,
  ) async {
    final db = await database;

    return db.delete(
      'handlooms',
      where: 'p1 = ?',
      whereArgs: [id],
    );
  }

  // ==========================================================
  // TOTAL SURVEY COUNT
  // ==========================================================

  Future<int> getSurveyCount() async {
    final db = await database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM handlooms',
    );

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

    await db.delete('handlooms');
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
    final db = await database;

    await db.delete('handlooms');
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