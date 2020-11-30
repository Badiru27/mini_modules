import 'package:flutter/cupertino.dart';
import 'package:squiry_mini_modules/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:squiry_mini_modules/note/note_home.dart';
import 'package:squiry_mini_modules/note_database/note.dart';
import 'package:squiry_mini_modules/note_database/note_database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class AddNote extends StatefulWidget {

  final String appBarTitle;
  final PersonalNote note;

  AddNote(this.note, this.appBarTitle);

  @override
  _AddNoteState createState() => _AddNoteState(this.note, this.appBarTitle);
}

class _AddNoteState extends State<AddNote> {

  NoteDatabaseHelper helper = NoteDatabaseHelper();

  String appBarTitle;
  PersonalNote note;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();


  _AddNoteState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    titleController.text = note.title;
    descriptionController.text = note.description;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor1,
        title: Text(appBarTitle),
      ),

      body: Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(
                fontSize: 24,
                color: PrimaryColor2,
              ),
              maxLength: 50,
              controller: titleController,
              onChanged: (value) {
                updateTitle();
              },
              decoration: InputDecoration(
                  hintText: "Add Title...",
                  hintStyle: TextStyle(
                    fontSize: 24,
                    color: PrimaryColor2,
                  )
                  /* border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ) */
              ),
            ),
            SizedBox(height: 30),
            TextField(
              maxLines: null,
              controller: descriptionController,
              onChanged: (value) {
                updateDescription();
              },
              decoration: InputDecoration.collapsed(hintText: "write or past your note..",
              hintStyle: TextStyle(color: BodyColor2))
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap:  () {
                setState(() {
                             _save();
                           });},
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.check,
                      color: SecondaryColor2,),
                    ),
                 Text('Save',
                 style: TextStyle(
                   color: BodyColor2,
                 ),)
                  ],
                ),
              ),
              GestureDetector(
                onTap:() {
                  setState(() {
                    _delete();
                  });
                },
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.cancel_outlined,
                      color: SecondaryColor1,),

                    ),
                  Text('Delete',
                  style: TextStyle(
                    color: BodyColor2,
                  ),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //Update the title of Note object
  void updateTitle() {
    note.title = titleController.text;
  }

  //Update the description of Note object
  void updateDescription() {
    note.description = descriptionController.text;
  }

  //Save note to database
  void _save() async {

    Navigator.pop(context, true);

    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) { // Case1: Update Operation
      result = await helper.updateNote(note);
    } else { // Case2: Insert Operation
      result = await helper.insertNote(note);
    }
    if (result == 0) { // Failure
     _showDialog('Failed', 'Note not Save Successfully');
    } else { //Success
     _showDialog('Success', 'Note Saved Successfully');
    }
  }

  //Delete note from the Database
  void _delete() async{

    Navigator.pop(context, true);

    //Case1: When the User is trying to delete a New note by pressing the  Floating Action Button
   if(note.id == null){
     _showDialog('New Note Deleted', 'New Note was Not Creates');
   return;
   }

   //Case2: When the trying to delete a note with an active id
  int result =  await helper.deleteNote(note.id);

   if (result == 0) { // Failure
     _showDialog('Failed', 'Note not Deleted Successfully');
   } else { //Success
     _showDialog('Success', 'Note Deleted Successfully');
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



