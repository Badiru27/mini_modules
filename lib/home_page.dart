import 'package:flutter/material.dart';
import 'main.dart';
import 'package:squiry_mini_modules/widgets/button.dart';
import 'package:squiry_mini_modules/note/note_home.dart';
import 'package:squiry_mini_modules/exam/exam_home.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Squiry App'),
        backgroundColor: PrimaryColor1,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Column(
          children: [
            Container(
              child: BigButton(
                name: 'PersonalNote',
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return NoteHome();
                  }));
                },
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: BigButton(
                name: 'Exam Timetable',
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ExamTimeTable();
                  }));
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}
