import 'dart:io';

import 'package:fl_project/domain/data/product_data.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

  class DatabaseHelper {

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'my_table';

  static final columnNumber = 'number';
  static final columnCode = 'code';
  static final columnName= 'name';
  static final columnCount = 'count';
  static final columnPrice = 'price';
  static final columnSum = 'sum';





  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();


  Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
  return _database!;
  }


  initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);

  }


  Future _onCreate(Database db, int version) async {
  await db.execute('''
          CREATE TABLE $table (
            $columnNumber INTEGER PRIMARY KEY,
            $columnCode TEXT NOT NULL,
            $columnName TEXT NOT NULL,
            $columnCount INTEGER NOT NULL,
            $columnPrice TEXT NOT NULL,
            $columnSum TEXT NOT NULL
          )
          ''');
  }


  Future<int> insert(Map<String, dynamic> row) async {
  Database db = await instance.database;
  return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
  Database db = await instance.database;
  return await db.query(table);
  }

  Future<int> delete(int id) async {
  Database db = await instance.database;
  return await db.delete(table, where: '$columnNumber = ?', whereArgs: [id]);
  }
}