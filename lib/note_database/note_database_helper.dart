import 'note.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class NoteDatabaseHelper{

  static NoteDatabaseHelper _databaseHelper; //Singleton DatabaseHelper
  static Database _database;                //Singleton Database

  String noteTable = 'note_table';
  String colID = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';

  NoteDatabaseHelper._createInstance();

  factory NoteDatabaseHelper(){
    if(_databaseHelper == null){
      _databaseHelper = NoteDatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async{
    if(_database ==null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    // Getting Directory for both iOS and Android to store Note Database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    // Open/Create the database at a given path
    var noteDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return noteDatabase;
  }

  void _createDb(Database db, int newVersion) async{
    await db.execute('CREATE TABLE $noteTable($colID INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colTitle TEXT, $colDescription TEXT, $colDate TEXT)');
  }

  // Fetching Operation: Get all note object from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async{
    Database db = await this.database;

    var result = await db.query(noteTable, orderBy: '$colDate ASC');
    return result;
  }

  // Inserting Operation: Inserting and saving Note to the database

  Future<int> insertNote(PersonalNote note) async{
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

//Update Operation: Updating and saving Note to the database
  Future<int> updateNote(PersonalNote note) async{
    Database db = await this.database;
    var result = await db.update(noteTable, note.toMap(), where: '$colID = ?', whereArgs: [note.id]);
    return result;
  }

  //Deleting Operation: Deleting Notes from the database
  Future<int> deleteNote(int id) async{
    Database db = await this.database;
    int result = await db.rawDelete('DELETE FROM $noteTable WHERE $colID = $id');
    return result;
  }

//Getting the numbers of note in the database

  Future<int> getCount() async{
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }


  Future<List<PersonalNote>> myNoteList() async{

    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;

    List<PersonalNote> noteList = List<PersonalNote>();

    for(int i=0; i< count; i++){
      noteList.add(PersonalNote.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }

}