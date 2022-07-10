import 'package:flutter/material.dart';

Widget customInputFormWidget(context, {String title, TextFormField input}) {
  return Container(
    height: MediaQuery.of(context).size.height * (90 / 812),
    child: Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(title, style: TextStyle(color: Theme.of(context).accentColor),),
        ),
        SizedBox(height: 5,),
        Expanded(child: input),
      ],
    ),
  );
}