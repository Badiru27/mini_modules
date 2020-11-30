
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squiry_mini_modules/note/add_note.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import'package:squiry_mini_modules/note_database/note_database_helper.dart';
import'package:squiry_mini_modules/note_database/note.dart';
import 'package:squiry_mini_modules/main.dart';
import 'package:squiry_mini_modules/widgets/empty_display_holder.dart';

class NoteHome extends StatefulWidget {
  @override
  _NoteHomeState createState() => _NoteHomeState();
}

class _NoteHomeState extends State<NoteHome> {

  NoteDatabaseHelper databaseHelper = NoteDatabaseHelper();
  List<PersonalNote> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<PersonalNote>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Note'),
        backgroundColor: PrimaryColor1,
      ),
      body: Container(
        child: (count!=0) ? myNoteList(): DisplayHolder(
            'You have no note',
            'Create a personal Note', Icons.note_add,
            (){navigateToAdd(PersonalNote('', '', ''), 'Add New Note');}),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAdd(PersonalNote('', '', ''), 'Add New Note');
        },

        tooltip: 'Add Personal Note',
        child: Icon(Icons.add,
          size: 25,),
        backgroundColor: SecondaryColor2,
      ),
    );
  }

  //List view container decorator.
  ListView myNoteList() {

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: InkWell(
            onTap: () {
              navigateToAdd(this.noteList[position], 'Edit Note');
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFBFACBF),
                      blurRadius: 2,
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 30, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(this.noteList[position].title,
                      style: TextStyle(
                        color: BodyColor1,
                        fontSize: 14,
                      ),),
                    //SizedBox(width: 30),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_rounded,
                          color: Color(0xFF898989),),
                        SizedBox(width: 5),
                        Container(
                          color: Color(0xFFEE3C00),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20, 5.0, 20.0, 5.0),
                            child: Text(this.noteList[position].date,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),),
                          ),
                        )
                      ],
                    ),


                  ],),
              ),

            ),
          ),
        );
      },
    );
  }

  // Navigating to Add Note
  void navigateToAdd(PersonalNote note, String title) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) {
      return AddNote(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }


//Update ListView

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<PersonalNote>> noteListFuture = databaseHelper.myNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }



}


