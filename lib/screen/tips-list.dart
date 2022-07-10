import 'package:epic/utils/assets.dart';
import 'package:flutter/material.dart';

class TipsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.bgMainBackground),
            fit: BoxFit.fill,
          ),
        ),
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
                child: ListView.builder(itemCount: 2, itemBuilder: (context, index) {
                  return Container(child: _tipItem(context),);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _tipItem(context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "/Tip"),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.lightbulb_outline_rounded, color: Colors.black, size: 56,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tips", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text("Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit")
                  ],
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,),
              ],
            ),
            SizedBox(height: 10,),
            Container(height: 1, width: MediaQuery.of(context).size.width * 0.7, color: Colors.grey,),
          ],
        ),
      ),
    );
  }

}
