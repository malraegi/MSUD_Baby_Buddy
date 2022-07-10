import 'package:epic/utils/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:epic/utils/extensions.dart';

class ChatMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.bgMainBackground),
            fit: BoxFit.fill,
          ),
        ),
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
                child: ListView.builder(itemCount: 10, itemBuilder: (context, index) {
                  return Container(child: _chatItem(context),);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _chatItem(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * (70 / 375),
                height: MediaQuery.of(context).size.width * (70 / 375),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 5),
                ),
                child: Stack(
                  children: [
                    Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 40,
                        )),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Container(
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Dr. Mohammed", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit")
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, "/Chat"),
                child: Container(
                  child: Text("chat", style: TextStyle(color: Colors.white),),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: "2a58a1".toHexa(),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
