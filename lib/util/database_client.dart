import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:notdoapp/model/nodo_item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseClient {
  static final DatabaseClient instance = DatabaseClient.internal();
  factory DatabaseClient()=>instance;
  final String tableName="nodoTbl";
  final String columnId="id";
  final String columnItemName="itemName";
  final String columnDateCreated="dateCreated";

  static Database? _db;
  Future<Database?> get db async{
    if(_db !=null){
      return _db;
    }
    _db=await initDb();
    return _db;
  }
  DatabaseClient.internal();


  initDb() async {
    Directory dir= await getApplicationDocumentsDirectory();
    String path= join(dir.path,"nodo_db.db");
    return await openDatabase(path,version: 1,onCreate: _onCreate);

  }
  

  void _onCreate(Database db, int version) async{
    await db.execute(
      "CREATE TABLE $tableName(id INTEGER PRIMARY KEY, $columnItemName TEXT, $columnDateCreated TEXT)"
    );
  }
  Future<int>saveItem(NoDoItem item)async{
    var dbClient= await db;
    int res = await dbClient!.insert(tableName, item.toMap());
    return res;
  }
  Future<List>getItems()async{
    var dbClient =await db;
    var result =await dbClient!.rawQuery("SELECT * FROM $tableName ORDER BY $columnItemName ASC");

    return result.toList();
  }
  Future<int?>getCount()async{
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient!.rawQuery(
      "SELECT COUNT(*) FROM $tableName"
    ));
  }
  Future<NoDoItem?>getItem(int id)async{
    var dbClient = await db;
    var result = await dbClient!.rawQuery(
      "SELECT * FROM $tableName WHERE id=$id"
          
    );
    if(result.length==0){
      return null;
    }
    return NoDoItem.fromMap(result.first);
  }
  Future<int>deleteItem(int id)async{
    var dbClient= await db;
    return await dbClient!.delete(tableName,where: "$columnId = ?",whereArgs: [id]);
    
  }
  Future<int>updateItem(NoDoItem item)async{
    var dbClient= await db;
    return await dbClient!.update(tableName, item.toMap(),where: "$columnId = ?",whereArgs: [item.id]);

  }
  Future close()async{
    var dbClient= await db;
    return dbClient!.close();
  }

}
