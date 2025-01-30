import 'package:sqflite/sqflite.dart';
import 'package:sqlite_demo/utils/db_helper.dart';

class GalleryRepository{
  late GalleryDbHelper _dbHelper;
  static Database? _database;

  GalleryRepository(){
    _dbHelper = GalleryDbHelper();
    initDatabase();
  }

  void initDatabase() async{
    _database = await _dbHelper.initDb();
  }

  Future<Database?> get database async{
    _database ??= await _dbHelper.initDb();
    return _database;
  }

  insertData(table, data) async{
    var connection = await database;
    return await connection?.insert(table, data);
  }

  readData(table) async{
    var connection = await database;
    return await connection?.query(table);
  }

  deleteData(table, id) async {
    var connection = await database;
    return await connection?.
    rawDelete("DELETE FROM $table WHERE id = $id");
  }

}