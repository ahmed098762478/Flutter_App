import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Represent/CryptoChartScreen.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL,
        isConnected INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE crypto_prices(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        open REAL NOT NULL,
        high REAL NOT NULL,
        low REAL NOT NULL,
        close REAL NOT NULL
      )
    ''');
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('users', user);
  }

  Future<void> addIsConnectedColumn() async {
    final db = await database;

    // Ajoute la colonne isConnected si elle n'existe pas déjà
    try {
      await db.execute('''
        ALTER TABLE users ADD COLUMN isConnected INTEGER DEFAULT 0
      ''');
    } catch (e) {
      // La colonne existe déjà
    }
  }

  Future<Map<String, dynamic>?> getUserByEmailAndPassword(
      String email, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('users');
  }

  Future<void> updateUserPassword(String email, String newPassword) async {
    final db = await database;
    await db.update(
      'users',
      {'password': newPassword},
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'isConnected = ?',
      whereArgs: [1],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> setCurrentUser(String email) async {
    final db = await database;

    // Déconnecter tous les utilisateurs
    await db.update('users', {'isConnected': 0});

    // Marquer l'utilisateur donné comme connecté
    await db.update(
      'users',
      {'isConnected': 1},
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  Future<void> insertCryptoPrice(CandleStickData data) async {
    final db = await database;
    await db.insert('crypto_prices', {
      'date': data.date,
      'open': data.open,
      'high': data.high,
      'low': data.low,
      'close': data.close,
    });
  }

  Future<List<Map<String, dynamic>>> getSavedCryptoPrices() async {
    final db = await database;
    return await db.query('crypto_prices', orderBy: 'id ASC');
  }

 

}
