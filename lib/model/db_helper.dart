import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_noty/model/note.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'constans.dart';


class DbHelper{
  static const DbHelper _helper = DbHelper.internal();
  const DbHelper.internal();
  factory DbHelper()=> _helper;
  static Database? _database;

  static final note_title = TextEditingController();
  static final note_content = TextEditingController();
  static final creation_data=TextEditingController();
  static int color_id = Random().nextInt(AppStyle.cardsColor.length);
  static String date = DateTime.now().toString();
  static late  Note notes;


  DbHelper get helper => _helper;
  Database? get dataBase => _database;

   Future<Database?>createDataBase()async{
    if(_database != null){
      return _database;
    }else{
      Directory directory =await getApplicationDocumentsDirectory();
      String path = join(directory.path,'posts.abc');
      _database =await openDatabase(path,version: 1,onCreate: (db,index){
       db.execute("CREATE TABLE notes ( id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,title TEXT varchar (50),content TEXT varchar(300), date TEXT varchar(30) )");
      });
      return _database;
    }
  }
  //
   Future<int>createNote(Note note)async{
    Database?  base = await createDataBase();
    return base!.insert('notes', note.toJson());

  }
//
   Future<List>selectAllNotes()async{
    Database? dataBase =  await createDataBase();
    return dataBase!.query('notes');
  }

   Future readAllNotes() async{
    Database? data =await createDataBase();
    return data!.query('notes');
  }
  //
   Future<int>deleteNotes(int id)async{
    Database? dataBase =  await createDataBase();
    return dataBase!.delete('notes',where: 'id = ? ',whereArgs: [id]);
  }
  //
   Future<int>updateNotes(Note note)async{
    Database? dataBase =  await createDataBase();
    return dataBase!.update('notes', note.toJson(),where: 'id = ?',whereArgs: [note.id]);
  }

}
