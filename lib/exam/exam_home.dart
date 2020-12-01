import 'package:flutter/material.dart';
import 'package:squiry_mini_modules/exam/add_exam.dart';
import 'package:squiry_mini_modules/main.dart';
import 'dart:async';
import 'package:squiry_mini_modules/exam_database/exam_database_helper.dart';
import 'package:squiry_mini_modules/exam_database/exam.dart';
import 'package:sqflite/sqflite.dart';
import 'package:squiry_mini_modules/widgets/empty_display_holder.dart';
import 'package:squiry_mini_modules/widgets/dailog.dart';

class ExamTimeTable extends StatefulWidget {
  @override
  _ExamTimeTableState createState() => _ExamTimeTableState();
}

class _ExamTimeTableState extends State<ExamTimeTable> {

  ExamDatabaseHelper databaseHelper = ExamDatabaseHelper();
  List<ExamDatabase> examList;
  int count = 0;

  @override
  Widget build(BuildContext context) {

    if(examList == null ){
      examList = List<ExamDatabase>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor1,
        title: Text('Exam Timetable'),
      ),

      body: Container(child:
      (count != 0) ? myExam() : DisplayHolder(
          'You have no Exam TimeTable',
          'Create an Exam Timetable',
          Icons.chrome_reader_mode,
          (){navigateToAddExam(ExamDatabase('', '', '', '', '', ''));}),
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Personal Note',
        child: Icon(Icons.add,
          size: 25,),
        backgroundColor: SecondaryColor2,
        onPressed: (){
          return /* showDialog(
              context: context,
              builder: (BuildContext context) {
                return MyDialog();
              }); */



            navigateToAddExam(ExamDatabase('', '', '', '', '', ''));
        },
      ),
    );
  }

  //Exam List Decorator
ListView myExam(){

    return ListView.builder(
      itemCount: count,
        itemBuilder: (BuildContext context, int position){
        return GestureDetector(

          onTap: (){
            navigateToAddExam(this.examList[position]);
          },

          child: Container(
            margin: EdgeInsets.fromLTRB(20.00, 20.00, 20.00, 10.00),
            padding: EdgeInsets.all(20.00),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFBFACBF),
                    blurRadius: 2,
                  )
                ]
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(this.examList[position].courseCode.toUpperCase(),
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF222222)
                      ),),
                    SizedBox(height: 20.00),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            color: Color(0xFF898989)),
                        Text(this.examList[position].venue,
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF898989)
                          ),),
                      ],
                    ),
                  ],
                ),
            //    SizedBox(width: 30.00),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.00),
                          color: Color(0xFFEE3C00),
                          child: Text(this.examList[position].fromTime,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.00),
                          color: Color(0xFF00536F),
                          child: Text(this.examList[position].toTime,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),),
                        )
                      ],
                    ),
                    SizedBox(height: 10.00),
                    Row(
                      children: [
                        Icon(Icons.person,
                            color: Color(0xFF898989)),
                        SizedBox(width: 5.00),
                        Text(this.examList[position].date,
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF898989)
                          ),),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
        }
    );
}

// Updating ListView

void updateListView(){

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<ExamDatabase>> examListFuture = databaseHelper.getExamList();
      examListFuture.then((examList) {
        setState(() {
          this.examList =examList;
          this.count = examList.length;
        });
      });
    });
}

  //Navigating
  void navigateToAddExam(ExamDatabase exam) async{
   bool result = await showDialog(
       barrierDismissible: false,
       context: context,
       builder: (BuildContext context) {
         return AddExam(exam);
       });

   if (result == true){
     updateListView();
   }
  }

}

