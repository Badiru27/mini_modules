import 'package:flutter/material.dart';
import 'package:squiry_mini_modules/main.dart';

class BigButton extends StatelessWidget {

  final String name;
  final VoidCallback onPressed;
  BigButton({this.name, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 30, 20, 30),
      child: Container(
        child: MaterialButton(
          minWidth: 300,
          onPressed : onPressed,
          color: PrimaryColor1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          textColor: Colors.white,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Text(name,
            style: TextStyle(
              fontSize: 18,
            ),),
        ),
      ),
    );
  }
}


// Custom Delete and Cancel ButtonBar

class DeleteCancel extends StatelessWidget {

  final VoidCallback onPressedDelete;
  final VoidCallback onPressedCancel;

  DeleteCancel({this.onPressedCancel, this.onPressedDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 30, 20, 20),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onPressedDelete,
              child: Row(
                children: [
                  Icon(Icons.delete,
                  color: SecondaryColor1,),
                  SizedBox(width: 10),
                  Text('DELETE',
                  style: TextStyle(
                    color: SecondaryColor1,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400
                  ),),
                ],
              ),
            ),
            GestureDetector(
              onTap: onPressedCancel,
              child: Row(
                children: [
                  Icon(Icons.cancel,
                  color: SecondaryColor1),
                  SizedBox(width: 10),
                  Text('Cancel',
                    style: TextStyle(
                        color: SecondaryColor1,
                        fontSize: 18.0,
                    ),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
