import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../common/const/const.dart';


const tableAddress = 'address_table';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();

  factory LocalDatabase() => _instance;
  static Database? _database;

  LocalDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
        path,
        version: dbVersion,
        onCreate: _onCreate,
        onUpgrade: (db, oldVersion, newVersion) {
          if (oldVersion < newVersion) {
            // db.rawQuery('drop table $tableStudent');
            // _onCreate(db, newVersion);
          }
        }
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE address_table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            image_id TEXT NOT NULL,
            latitude REAL NOT NULL,
            longitude REAL NOT NULL,
            address TEXT NOT NULL,
            raw_data TEXT NOT NULL
        )
    ''');
  }

  Future<int> insertData(String table, Map<String, dynamic> item) async {
    Database db = await database;
    return await db.insert(table, item);
  }

  Future<List<Map<String, dynamic>>> getItems(String table) async {
    Database db = await database;
    return await db.query(table);
  }

  Future<int> updateItem(String table, Map<String, dynamic> item) async {
    Database db = await database;
    int id = item['id'];
    return await db.update(table, item, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteItem(String table, int id) async {
    Database db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
