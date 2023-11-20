import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:weather_app/database/city_db.dart';

class DatabaseService {

  Database? _database;

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<String> get fullPath async {
    const tableName = 'cities.db';
    final path = await getDatabasesPath();
    return join(path, tableName);
  }

  Future<Database> initializeDatabase() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
      singleInstance: true,
    );
    return database;
  }

  void _createDb(Database database, int version) async =>
      await CityDB().createTable(database);

}
