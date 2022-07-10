import 'package:epic/styles/customStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget dropDownAuth(context, { String title, String hintText, List<String> items, Function onChange }) {
  return Container(
    height: MediaQuery.of(context).size.height * (90 / 812),
    child: Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(title, style: TextStyle(color: Color.fromRGBO(47, 128, 237, 1)),),
        ),
        SizedBox(height: 5,),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    iconEnabledColor: Colors.transparent,
                    iconDisabledColor: Colors.transparent,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    hint: Container(padding: EdgeInsets.only(left: 80), child: Text(hintText)),
                    items: items.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) => onChange(value),
                  ),
                ),
                Container(child: Icon(Icons.arrow_drop_down, size: 56, color: Color.fromRGBO(47, 128, 237, 1),), decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: Color.fromRGBO(47, 128, 237, 1),),),
                ),),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// Row(
// children: [
// Icon(Icons.arrow_drop_down, size: 56, color: Color.fromRGBO(47, 128, 237, 1),),
// DropdownButtonFormField<String>(
// items: <String>['A', 'B', 'C', 'D'].map((String value) {
// return new DropdownMenuItem<String>(
// value: value,
// child: Text(value),
// );
// }).toList(),
// onChanged: (_) {},
// ),
// ],
// )