import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'exam.dart';

 class ExamDatabaseHelper{

   static ExamDatabaseHelper _databaseHelper; // Singleton DatabaseHelper
   static Database _database;

   //Defining Database Table
   String examTable = 'exam_table';
   String colId = 'id';
   String colCourseTitle = 'courseTitle';
   String colCourseCode = 'courseCode';
   String colVenue = 'venue';
   String colDate = 'date';
   String colFromTime = 'fromTime';
   String colToTime = 'toTime';


   ExamDatabaseHelper._createInstance();  //Named Constructor

   factory ExamDatabaseHelper(){
     if(_databaseHelper == null){
       _databaseHelper = ExamDatabaseHelper._createInstance(); // Executing only once singleton object
     }
     return _databaseHelper;
   }

   //Checking to create Database
   Future<Database> get database async{
     if(_database == null){
     _database = await initializeDatabase();}
     return _database;
   }

   //Initialising Database
   Future<Database> initializeDatabase() async{
     //Get the directory for both iOS and Android
     Directory directory = await getApplicationDocumentsDirectory();
     String path = directory.path + 'exam.db';

     //Open Database in a Given Path
     var examDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
     return examDatabase;
   }

   //Creating Database
  void _createDb(Database db, int newVersion) async{

     await db.execute('CREATE TABLE $examTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colCourseTitle TEXT,'
         '$colCourseCode TEXT, $colVenue TEXT, $colDate TEXT, $colFromTime TEXT, $colToTime TEXT)');

  }

  // Fetch Operation: Get all Exams from database
   Future<List<Map<String, dynamic>>> getExamMapList()  async{
     Database db = await this.database;

     var result = db.query(examTable, orderBy: '$colDate ASC, $colFromTime ASC');
     return result;
  }

   //Insert Operation: Inserting exams to the database
   Future<int> insertExam(ExamDatabase exam) async{
     Database db = await this.database;
     var result = await db.insert(examTable, exam.toMap());
     return result;
   }

   //Update Operation: Updating exams to the database
   Future<int> updateExam(ExamDatabase exam) async{
     var db = await this.database;
     var result = await db.update(examTable, exam.toMap(), where: '$colId = ?', whereArgs: [exam.id]);
     return result;
   }

   //Delete Operation: Deleting exams from the database
   Future<int> deleteExam(int id) async{
     var db = await this.database;
     int result = await db.rawDelete('DELETE FROM $examTable WHERE $colId = $id');
     return result;
   }

   // Get number of exams in the database
   Future<int> getCount() async{
     Database db = await this.database;
     List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $examTable');
     int result = Sqflite.firstIntValue(x);
     return result;
   }

   //Get list of Map from Database and convert it to Object
  Future<List<ExamDatabase>> getExamList() async{

     var examMapList = await getExamMapList();  // Map List from Database
     int count = examMapList.length;           //Count the number of map entries in the db table

    List<ExamDatabase> examList = List<ExamDatabase>();

    for (int i = 0; i < count; i++){
      examList.add(ExamDatabase.fromMapObject(examMapList[i]));
    }

    return examList;
   }


 }