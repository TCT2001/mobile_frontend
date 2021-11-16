import 'package:flutter/material.dart';

Widget InputField(BuildContext context,String labelText, {bool obscureText = false}) {
  return Padding(
    padding: EdgeInsets.only(top: 20, left: 50, right: 50),
    child: Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child:  TextField(
        obscureText: obscureText,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Colors.lightBlueAccent,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
    ),
  );
}