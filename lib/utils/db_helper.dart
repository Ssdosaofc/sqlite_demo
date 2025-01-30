import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper{


  initDb() async{
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path, 'students.db');

    var database = await openDatabase(path,version: 1,onCreate: _onCreate);

    return database;
  }

  _onCreate(Database database, int version) async{

    String schema = "CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)";

    await database.execute(schema);
  }
}

class GalleryDbHelper{

  initDb() async{
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path, 'images.db');

    var database = await openDatabase(path,version: 1,onCreate: _onCreate);

    return database;
  }

  _onCreate(Database database, int version) async{

    String schema = "CREATE TABLE images(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, base64string TEXT)";
    await database.execute(schema);
  }
}

