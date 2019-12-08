import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  static DatabaseConnection _databaseConnection; // Singleton DatabaseConnection
  static Database _database; // Singleton Database

  DatabaseConnection._createInstance(); // named constructor to create instance of DatabaseConnection

  factory DatabaseConnection() {
    if (_databaseConnection == null) {
      _databaseConnection = DatabaseConnection._createInstance();
    }
    return _databaseConnection;
  }

  // getter
  Future<Database> get database async {
    if (_database == null) {
      _database = await _openConnection();
    }
    return _database;
  }

  Future<Database> _openConnection() async {
    return openDatabase(
      join(await getDatabasesPath(), "event_database.db"),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE events(id INTEGER PRIMARY KEY, name TEXT, location TEXT, start_time TEXT, end_time TEXT)",
        );
      },
      version: 1,
    );
  }
}
