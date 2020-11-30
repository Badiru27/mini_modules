import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:squiry_mini_modules/main.dart';

//Class for Input Text Field Design
class InputField extends StatelessWidget {

  final IconData custom;  //Field Icon Type
  final String name;      // Field Name
  final String placeHolder;  // TextField Hint Text
  final TextEditingController myControl;
  final Function onChanged;

  InputField({ this.custom, this.name, this.placeHolder, this.myControl, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Row(
              children: [
                Icon(custom,
                  color: BodyColor2,),
                SizedBox(width: 10.00),
                Text(name.toUpperCase(),
                  style: TextStyle(
                    color: BodyColor2,
                    fontSize: 12.00,
                    fontWeight: FontWeight.bold,

                  ),)
              ],
            ),
          ),
          SizedBox(height: 10.00),
          TextField(
            onChanged: onChanged,
            controller: myControl,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                hintText: placeHolder,
                labelStyle: TextStyle(
                  fontSize: 14.00,
                  color: BodyColor1,
                )),
          )

        ],
      ),
    );
  }
}

// Class for Time Design
class Time extends StatelessWidget {

  final String name; // Text of Time
  Time({this.name });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Icon(Icons.access_time_outlined,
              color: BodyColor2,),
            SizedBox(width: 10.0),
            Text(name.toUpperCase(),
              style: TextStyle(
                color: BodyColor2,
                fontSize: 12.00,
                fontWeight: FontWeight.bold,

              ),),
          ],
        ),

      ],
    );
  }
}


// Class for Date Design
class Date extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Icon(Icons.calendar_today_rounded,
              color: BodyColor2,),
            SizedBox(width: 10.0),
            Text('DATE',
              style: TextStyle(
                color: BodyColor2,
                fontSize: 12.00,
                fontWeight: FontWeight.bold,

              ),),
          ],
        ),

      ],
    );
  }
}
