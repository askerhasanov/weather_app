import 'package:sqflite/sqflite.dart';
import 'package:weather_app/models/citydata.dart';

import 'databasehelper.dart';

class CityDB{
  final tableName ='cities';
  String colId = 'id';
  String colCityId = 'cityId';
  String colName = 'name';
  String colCountry = 'country';
  String colLat = 'lat';
  String colLon = 'lon';
  String colDate = 'date';

  Future<void> createTable(Database database) async {
    await database.execute('''CREATE TABLE $tableName (
    $colId INTEGER PRIMARY KEY AUTOINCREMENT,
    $colCityId TEXT,
    $colName TEXT,
    $colCountry TEXT,
    $colLat TEXT,
    $colLon TEXT,
    $colDate INTEGER)
    ''');
  }

  Future<int> create({required CityData city}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (cityId, name, country, lat, lon, date) VALUES (?,?,?,?,?,?)''',
      [city.id, city.name, city.country, city.lat, city.long, DateTime.now().microsecondsSinceEpoch],
    );
  }
  Future<List<CityData>> fetchAll() async {
    final database = await DatabaseService().database;
    final cities = await database.rawQuery(
      '''SELECT * from $tableName ORDER BY date'''
    );
    return cities.map((city) => CityData.fromDatabase(city)).toList();
  }
  Future<CityData> fetchCityDataById(String id) async {
    final database = await DatabaseService().database;
    final city = await database.rawQuery(
      '''SELECT * from $tableName WHERE id = ?''', [id]);
    return CityData.fromDatabase(city.first);
  }

  Future<void> delete(String id) async {
    final database =  await DatabaseService().database;
    await database.rawDelete('''DELETE FROM $tableName WHERE id = ?''', [id]);
  }

}