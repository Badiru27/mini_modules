import 'package:flutter/material.dart';
import 'package:squiry_mini_modules/main.dart';

// Show Dialog Box

class MyDialog extends StatelessWidget {

  /*
  String title;
  String message;
  MyDialog(this.title, this.message);
   */

  @override
  Widget build(BuildContext context) {
    return dialogContent(context);
  }

  dialogContent(BuildContext context){
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 16),
       //   height: 200,
          decoration: BoxDecoration(
              borderRadius : BorderRadius.circular(15),
              color: PrimaryColor1,
            shape: BoxShape.rectangle,
          ),

          child: Padding(
            padding: const EdgeInsets.only(
              top: 100,
              bottom: 16,
              right: 16,
              left: 16
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min
              ,
              children: [
                Text('title'),
                SizedBox(height: 30),
                Text('message')
              ],
            ),
          ),
        )
      ],
    );
  }

}


