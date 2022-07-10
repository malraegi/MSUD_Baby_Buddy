import 'package:flutter/material.dart';

class Tip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Color.fromRGBO(11, 127, 254, 1),
                      ),
                      Text(
                        "Back",
                        style: TextStyle(
                          color: Color.fromRGBO(11, 127, 254, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Icon(Icons.lightbulb, size: 56,),
                    SizedBox(height: 10,),
                    Text("What is my child’s disease?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    SizedBox(height: 30,),
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget nisl iaculis orci vestibulum commodo. Proin ut enim vel purus venenatis sodales tristique sit amet magna. Integer tristique bibendum arcu, vel posuere leo scelerisque sed. Maecenas elit nisl, eleifend sit amet orci nec, malesuada venenatis eros. Nullam congue neque ac turpis mattis lacinia. Maecenas nisi purus, sagittis ac orci sed, rhoncus vehicula lectus. Aenean at placerat enim. Mauris at ex convallis, aliquet tortor quis, ornare lorem", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 18),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
