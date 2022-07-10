import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:epic/utils/extensions.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dr. Mohammed", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
        centerTitle: true,
        backgroundColor: "#68708a".toHexa(),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: ListView.builder(itemCount: 5, itemBuilder: (context, index) {
                return _chatItem();
              }),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * (80 / 812),
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Write message",
                  ),),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Text("Send", style: TextStyle(color: Colors.white),),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _chatItem() {
    return Column(
      children: [
        Row(children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(Icons.person, color: Colors.white, size: 36,),
            ),
          ),
          SizedBox(width: 20,),
          Expanded(child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Text("this is message", style: TextStyle(color: Colors.black54),),
          )),
        ],),
      ],
    );
  }

}
