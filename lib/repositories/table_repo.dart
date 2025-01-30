import 'package:sqflite/sqflite.dart';
import 'package:sqlite_demo/utils/db_helper.dart';

class TableRepository{
  late DbHelper _dbHelper;
  static Database? _database;

  TableRepository(){
    _dbHelper = DbHelper();
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

  readDataById(table, id) async{
    var connection = await database;
    return await connection?.
      query(table,where: 'id=?',whereArgs: [id]);
  }

  updateData(table, data) async{
    var connection = await database;
    return await connection?.
      update(table, data, where: 'id=?',whereArgs: [data['id']]);
  }

  deleteData(table, id) async {
    var connection = await database;
    return await connection?.
      rawDelete("DELETE FROM $table WHERE id = $id");
  }

}