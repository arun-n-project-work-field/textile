import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance =
      DatabaseHelper._privateConstructor();

  static Database? _database;

  // ----------------------------------------------------------
  // DATABASE
  // ----------------------------------------------------------

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  // ----------------------------------------------------------
  // INITIALIZE DATABASE
  // ----------------------------------------------------------

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(
      databasePath,
      'namma_kaimagga.db',
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // ----------------------------------------------------------
  // CREATE TABLES
  // ----------------------------------------------------------

  Future<void> _onCreate(
    Database db,
    int version,
  ) async {
    await db.execute('''
      CREATE TABLE handlooms (
        id TEXT PRIMARY KEY,
        latitude TEXT NOT NULL,
        longitude TEXT NOT NULL,
        accuracy TEXT NOT NULL,
        captureDateTime TEXT NOT NULL,
        handloomPhoto TEXT,
        weaverPhoto TEXT,
        remarks TEXT,
        syncStatus TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE products (
        id TEXT PRIMARY KEY,
        handloomId TEXT NOT NULL,
        productName TEXT NOT NULL,
        category TEXT NOT NULL,
        material TEXT,
        colour TEXT,
        design TEXT,
        length REAL,
        width REAL,
        weight REAL NOT NULL,
        quantity INTEGER NOT NULL,
        price REAL NOT NULL,
        manufactureDate TEXT,
        barcode TEXT NOT NULL,
        imagePath TEXT,
        remarks TEXT,
        syncStatus TEXT NOT NULL
      )
    ''');
  }

  // ----------------------------------------------------------
  // INSERT HANDLOOM
  // ----------------------------------------------------------

  Future<int> insertHandloom(
    Map<String, dynamic> data,
  ) async {
    final db = await database;

    return await db.insert(
      'handlooms',
      data,
      conflictAlgorithm:
          ConflictAlgorithm.replace,
    );
  }

  // ----------------------------------------------------------
  // GET ALL HANDLOOMS
  // ----------------------------------------------------------

  Future<List<Map<String, dynamic>>>
      getAllHandlooms() async {
    final db = await database;

    return await db.query(
      'handlooms',
      orderBy: 'captureDateTime DESC',
    );
  }

  // ----------------------------------------------------------
  // GET PENDING HANDLOOMS
  // ----------------------------------------------------------

  Future<List<Map<String, dynamic>>>
      getPendingHandlooms() async {
    final db = await database;

    return await db.query(
      'handlooms',
      where: 'syncStatus = ?',
      whereArgs: ['Pending'],
      orderBy: 'captureDateTime DESC',
    );
  }

  // ----------------------------------------------------------
  // GET HANDLOOM BY ID
  // ----------------------------------------------------------

  Future<Map<String, dynamic>?>
      getHandloomById(
    String id,
  ) async {
    final db = await database;

    final result = await db.query(
      'handlooms',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }

  // ----------------------------------------------------------
  // UPDATE HANDLOOM
  // ----------------------------------------------------------

  Future<int> updateHandloom(
    String id,
    Map<String, dynamic> data,
  ) async {
    final db = await database;

    return await db.update(
      'handlooms',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ----------------------------------------------------------
  // UPDATE SYNC STATUS
  // ----------------------------------------------------------

  Future<int> updateHandloomSyncStatus(
    String id,
    String status,
  ) async {
    final db = await database;

    return await db.update(
      'handlooms',
      {
        'syncStatus': status,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ----------------------------------------------------------
  // DELETE HANDLOOM
  // ----------------------------------------------------------

  Future<int> deleteHandloom(
    String id,
  ) async {
    final db = await database;

    return await db.delete(
      'handlooms',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ==========================================================
  // PRODUCTS
  // ==========================================================

  // ----------------------------------------------------------
  // INSERT PRODUCT
  // ----------------------------------------------------------

  Future<int> insertProduct(
    Map<String, dynamic> data,
  ) async {
    final db = await database;

    return await db.insert(
      'products',
      data,
      conflictAlgorithm:
          ConflictAlgorithm.replace,
    );
  }

  // ----------------------------------------------------------
  // GET ALL PRODUCTS
  // ----------------------------------------------------------

  Future<List<Map<String, dynamic>>>
      getAllProducts() async {
    final db = await database;

    return await db.query(
      'products',
      orderBy: 'id DESC',
    );
  }

  // ----------------------------------------------------------
  // GET PRODUCTS FOR HANDLOOM
  // ----------------------------------------------------------

  Future<List<Map<String, dynamic>>>
      getProductsByHandloomId(
    String handloomId,
  ) async {
    final db = await database;

    return await db.query(
      'products',
      where: 'handloomId = ?',
      whereArgs: [handloomId],
      orderBy: 'id DESC',
    );
  }

  // ----------------------------------------------------------
  // GET PENDING PRODUCTS
  // ----------------------------------------------------------

  Future<List<Map<String, dynamic>>>
      getPendingProducts() async {
    final db = await database;

    return await db.query(
      'products',
      where: 'syncStatus = ?',
      whereArgs: ['Pending'],
      orderBy: 'id DESC',
    );
  }

  // ----------------------------------------------------------
  // GET PRODUCT BY ID
  // ----------------------------------------------------------

  Future<Map<String, dynamic>?>
      getProductById(
    String id,
  ) async {
    final db = await database;

    final result = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }

  // ----------------------------------------------------------
  // UPDATE PRODUCT
  // ----------------------------------------------------------

  Future<int> updateProduct(
    String id,
    Map<String, dynamic> data,
  ) async {
    final db = await database;

    return await db.update(
      'products',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ----------------------------------------------------------
  // UPDATE PRODUCT SYNC STATUS
  // ----------------------------------------------------------

  Future<int> updateProductSyncStatus(
    String id,
    String status,
  ) async {
    final db = await database;

    return await db.update(
      'products',
      {
        'syncStatus': status,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ----------------------------------------------------------
  // DELETE PRODUCT
  // ----------------------------------------------------------

  Future<int> deleteProduct(
    String id,
  ) async {
    final db = await database;

    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ----------------------------------------------------------
  // DELETE PRODUCTS OF HANDLOOM
  // ----------------------------------------------------------

  Future<int> deleteProductsByHandloomId(
    String handloomId,
  ) async {
    final db = await database;

    return await db.delete(
      'products',
      where: 'handloomId = ?',
      whereArgs: [handloomId],
    );
  }

  // ----------------------------------------------------------
  // COUNT HANDLOOMS
  // ----------------------------------------------------------

  Future<int> getHandloomCount() async {
    final db = await database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM handlooms',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  // ----------------------------------------------------------
  // COUNT PENDING HANDLOOMS
  // ----------------------------------------------------------

  Future<int> getPendingHandloomCount() async {
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

  // ----------------------------------------------------------
  // COUNT PRODUCTS
  // ----------------------------------------------------------

  Future<int> getProductCount() async {
    final db = await database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM products',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  // ----------------------------------------------------------
  // CLEAR DATABASE
  // ----------------------------------------------------------

  Future<void> clearDatabase() async {
    final db = await database;

    await db.delete('products');

    await db.delete('handlooms');
  }

  // ----------------------------------------------------------
  // CLOSE DATABASE
  // ----------------------------------------------------------

  Future<void> closeDatabase() async {
    final db = await database;

    await db.close();

    _database = null;
  }
}