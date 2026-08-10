import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'secureguard.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Tabel User
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT UNIQUE,
        phone TEXT,
        password TEXT,
        created_at TEXT
      )
    ''');

    // Tabel Riwayat Pencarian
    await db.execute('''
      CREATE TABLE search_history(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        query TEXT,
        type TEXT,
        detail TEXT,
        timestamp TEXT,
        user_id INTEGER
      )
    ''');

    // Tabel Laporan
    await db.execute('''
      CREATE TABLE reports(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        fraud_type TEXT,
        perpetrator_phone TEXT,
        perpetrator_account TEXT,
        status TEXT,
        date TEXT,
        user_id INTEGER
      )
    ''');

    // Tabel Favorit Edukasi
    await db.execute('''
      CREATE TABLE education_favorites(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        category TEXT,
        read_time TEXT,
        description TEXT,
        user_id INTEGER
      )
    ''');
  }

  // ============ USER METHODS ============

  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUserByEmailAndPassword(String email, String password) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [user['id']],
    );
  }

  // ============ SEARCH HISTORY METHODS ============

  Future<int> insertSearchHistory(Map<String, dynamic> history) async {
    Database db = await database;
    return await db.insert('search_history', history);
  }

  Future<List<Map<String, dynamic>>> getSearchHistory(int userId) async {
    Database db = await database;
    return await db.query(
      'search_history',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'timestamp DESC',
      limit: 20,
    );
  }

  Future<int> deleteSearchHistory(int id) async {
    Database db = await database;
    return await db.delete(
      'search_history',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> clearSearchHistory(int userId) async {
    Database db = await database;
    return await db.delete(
      'search_history',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  // ============ REPORT METHODS ============

  Future<int> insertReport(Map<String, dynamic> report) async {
    Database db = await database;
    return await db.insert('reports', report);
  }

  Future<List<Map<String, dynamic>>> getReports(int userId) async {
    Database db = await database;
    return await db.query(
      'reports',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'date DESC',
    );
  }

  // ============ FAVORITE EDUCATION METHODS ============

  Future<int> insertFavorite(Map<String, dynamic> favorite) async {
    Database db = await database;
    return await db.insert('education_favorites', favorite);
  }

  Future<List<Map<String, dynamic>>> getFavorites(int userId) async {
    Database db = await database;
    return await db.query(
      'education_favorites',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  Future<int> deleteFavorite(int id) async {
    Database db = await database;
    return await db.delete(
      'education_favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> isFavorite(String title, int userId) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'education_favorites',
      where: 'title = ? AND user_id = ?',
      whereArgs: [title, userId],
    );
    return result.isNotEmpty;
  }
}