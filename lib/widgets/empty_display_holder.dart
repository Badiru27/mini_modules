import 'package:flutter/material.dart';
import 'package:squiry_mini_modules/main.dart';

class DisplayHolder extends StatelessWidget {

 final  String shortText;
 final  String longText;
 final  IconData custom;
 VoidCallback onTap;

  DisplayHolder(this.shortText, this.longText, this.custom, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          height: 160,
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Icon(custom,
                  size: 60,
                  color: BodyColor2,),
                SizedBox(height: 10,),
                Text(shortText,
                  style: TextStyle(
                    color: PrimaryColor2,
                    fontSize: 14,
                  ),),
                SizedBox(height: 5,),
                Text(longText,
                  style: TextStyle(
                    color: BodyColor1,
                    fontSize: 14,
                  ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}