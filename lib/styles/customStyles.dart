import 'package:flutter/material.dart';

OutlineInputBorder customBorderInput = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.blue,
  ),
  borderRadius: BorderRadius.all(Radius.circular(10)),
);

InputDecoration customInputForm = InputDecoration(
  border: customBorderInput,
  focusedBorder: customBorderInput,
  enabledBorder: customBorderInput,
  filled: true,
  fillColor: Colors.white,
  hintStyle: TextStyle(
    fontSize: 18,
    color: Colors.grey,
  ),
);