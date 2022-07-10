import 'package:flutter/material.dart';

Widget btnMain({String title, Function action, bool isBlack = false}) {
  return OutlineButton(
      onPressed: action,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Text(
        title,
        style: TextStyle(color: isBlack ? Colors.black : Colors.white),
      ),
      borderSide: BorderSide(color: isBlack ? Colors.black : Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ));
}
