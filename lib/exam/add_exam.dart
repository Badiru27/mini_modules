import 'package:flutter/material.dart';
import 'package:squiry_mini_modules/main.dart';
import 'package:squiry_mini_modules/widgets/button.dart';
import 'package:squiry_mini_modules/widgets/custome_form.dart';
import 'dart:async';
import 'package:squiry_mini_modules/exam_database/exam_database_helper.dart';
import 'package:squiry_mini_modules/exam_database/exam.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class AddExam extends StatefulWidget {

  final ExamDatabase exam;
  AddExam(this.exam);

  @override
  _AddExamState createState() => _AddExamState(this.exam);
}

class _AddExamState extends State<AddExam> {



  String _setFromTime, _setToTime, _setDate;
  DateTime _selectedDate = DateTime.now();
  String _fromSelectedTime = '00:00';
  String _toSelectedTime = '00:00';


  // Date Picker
  Future _pickDate(BuildContext context) async{
   final  DateTime datepick = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.day,
        initialDate: _selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2021));

    if(datepick != null){
     setState(() {
       _selectedDate = datepick;
       _dateController.text =  DateFormat.yMMMd().format(_selectedDate);
     });
    }
  }

  // Start(From) time
  Future _fromTimePick() async{
    TimeOfDay  timepick = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );


    if(timepick != null){
      setState(() {
        final now = new DateTime.now();
        final dt = DateTime(now.year, now.month, now.day, timepick.hour, timepick.minute);
        final format = DateFormat.jm();
        _fromSelectedTime = format.format(dt);
        _fromTimeController.text = _fromSelectedTime;

      });
    }

  }

  // End(To) time
  Future _toTimePick() async{
   TimeOfDay  timepick = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );


     if(timepick != null){
       setState(() {
         final now = new DateTime.now();
         final dt = DateTime(now.year, now.month, now.day, timepick.hour, timepick.minute);
         final format = DateFormat.jm();
         _toSelectedTime = format.format(dt);
         _toTimeController.text = _toSelectedTime;
       });
     }

  }



  //Defining  Helper Class
  ExamDatabaseHelper helper = ExamDatabaseHelper();

  //Navigating
  final ExamDatabase exam;
  _AddExamState(this.exam);

  // Textfield Controller
  TextEditingController courseCodeController = TextEditingController();
  TextEditingController courseTitleController = TextEditingController();
  TextEditingController venueController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _fromTimeController = TextEditingController();
  TextEditingController _toTimeController = TextEditingController();

  @override
  void initState() {
    _dateController.text = DateFormat.yMMMd().format(DateTime.now());
    _fromTimeController.text = '00:00';
    _toTimeController.text = '00:00';

    super.initState();
  }

  @override
  void dispose() {

    _dateController.dispose();
    _fromTimeController.dispose();
    _toTimeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (exam.id != null){
      _dateController.text = exam.date;
    }

    if (exam.id != null){
      _fromTimeController.text = exam.fromTime;
    }
    if (exam.id != null){
      _toTimeController.text = exam.toTime;
    }

    courseCodeController.text = exam.courseCode;
    courseTitleController.text = exam.courseTitle;
    venueController.text = exam.venue;


    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.00),
        ),
        height: 550,
        width: 320,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DeleteCancel(
                onPressedCancel: (){ moveBack();},
                onPressedDelete: (){
                setState(() {
                  _delete();
                });
                },),
              InputField(custom: Icons.book,
                         name: 'course code',
                         placeHolder: 'Enter Course Code',
                         myControl: courseCodeController,
                         onChanged: (value){
                         updateCourseCode();
                         },),
              InputField(custom: Icons.book,
                         name: 'Course Title',
                         placeHolder: 'Enter Course Title',
                         myControl: courseTitleController,
                         onChanged: (value){
                         updateCourseTitle();
                         },),
              InputField(custom: Icons.location_pin,
                         name:'Venue',
                         placeHolder: 'Enter Exam Venue',
                         myControl: venueController,
                         onChanged: (value){
                          updateVenue();
                         },),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: InkWell(
                  onTap: (){
                    _pickDate(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Date(),
                      Container(
                        child: TextFormField(
                          style: TextStyle(fontSize: 16, color: BodyColor1, fontWeight: FontWeight.bold),
                          enabled: false,
                          controller: _dateController,
                          /*  onSaved: (String val) {
                              _setDate = val;
                            }, */
                         keyboardType: TextInputType.text,
                        onChanged:(value){updateDate();},
                          decoration: InputDecoration(
                                  disabledBorder:
                                  UnderlineInputBorder(borderSide: BorderSide.none),
                        )),

                      ),
                    ],
                  ),
                ),
              ),
             Padding(
               padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
               child: GestureDetector(
                 onTap: (){_fromTimePick();},
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Time(name: 'Time From',),
                     Container(
                       child: TextField(
                           style: TextStyle(fontSize: 16, color: BodyColor1, fontWeight: FontWeight.bold),
                           enabled: false,
                           controller: _fromTimeController,
                           keyboardType: TextInputType.text,
                           onChanged:(value){updateFromTime();},
                           decoration: InputDecoration(
                             disabledBorder:
                             UnderlineInputBorder(borderSide: BorderSide.none),
                           )),

                     ),
                   ],
                 ),
               ),
             ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: GestureDetector(
                  onTap: (){_toTimePick();},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Time(name: 'Time To',),
                      Container(
                        child: TextField(
                            style: TextStyle(fontSize: 16, color: BodyColor1, fontWeight: FontWeight.bold),
                            enabled: false,
                            controller: _toTimeController,
                            keyboardType: TextInputType.text,
                            onChanged:(value){updateToTime();},
                            decoration: InputDecoration(
                              disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                            )),

                      ),
                    ],
                  ),
                ),
              ),
              BigButton(name: 'Save Exam',
                onPressed: (){
                setState(() {
                  _save();
                });
              },),
            ],
          ),
        ),
      ),
    );
  }

  //Navigating to last screen
  void moveBack(){
    Navigator.pop(context, true);
  }

  // Update the CourseCode
 void updateCourseCode(){
    exam.courseCode = courseCodeController.text;
 }

  // Update the CourseTitle
  void updateCourseTitle(){
    exam.courseTitle = courseTitleController.text;
  }

  // Update the Venue
  void updateVenue(){
    exam.venue = venueController.text;
  }

  // Update the Date
  void updateDate(){
    exam.date = _dateController.text;
  }

  // Update the Start(From) Time
  void updateFromTime(){
    exam.fromTime = _fromTimeController.text;
  }

  // Update the End(To) Time
  void updateToTime(){
    exam.toTime = _toTimeController.text;
  }

  // Saving Data to the Database
  void _save() async{

    moveBack();
    exam.date = _dateController.text;
    exam.toTime = _toSelectedTime;
    exam.fromTime = _fromSelectedTime;

    int result;
    if(exam.id != null){ // Case1: Updating Operation

     result = await helper.updateExam(exam);

    } else{ // Case2: Inserting Operation

      result = await helper.insertExam(exam);
    }

    if (result == 0) { // Failure
      _showDialog('Failed', 'Exam not Saved Successfully');
    } else { //Success
      _showDialog('Success', 'Exam Saved Successfully');
    }
  }

  // Deleting Data from the Database
  void _delete() async{

    moveBack();

    // Deleting New not created Exam
    if(exam.id == null){
      _showDialog('New Note Deleted', 'New Note was Not Creates');
      return;
    }

    // Deleting Created Exam
   int result =  await helper.deleteExam(exam.id);

    if (result == 0) { // Failure
      _showDialog('Failed', 'Exam not Deleted Successfully');
    } else { //Success
      _showDialog('Success', 'Exam Deleted Successfully');
    }


  }

  // Show Dialog Box
  void _showDialog(String title, String message){

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }
}

