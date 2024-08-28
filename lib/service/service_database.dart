import 'package:anj_techtest/service/serivce_picture.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'pictures.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE pictures(id INTEGER PRIMARY KEY, imagePath TEXT, latitude REAL, longitude REAL, datetime TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertPicture(PictureModel picture) async {
    final db = await database;
    await db.insert(
      'pictures',
      picture.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
