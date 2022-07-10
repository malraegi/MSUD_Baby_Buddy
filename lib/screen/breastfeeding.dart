import 'package:epic/utils/assets.dart';
import 'package:epic/widgets/btn_main.dart';
import 'package:flutter/material.dart';

class Breastfeeding extends StatefulWidget {
  @override
  _BreastfeedingState createState() => _BreastfeedingState();
}

class _BreastfeedingState extends State<Breastfeeding> {

  List<bool> activeItems = [false, false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.bgMainBackground),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 30,),
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
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Text("Feeding formula per day", style: TextStyle(fontSize: 22, color: Theme.of(context).primaryColor),),
                    SizedBox(height: 30,),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 1 / 1.7,
                        children: List.generate(8, (index) {
                          return _itemList(context, index);
                        }),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * (40 / 812),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        btnMain(
                          title: "Next",
                          action: () => Navigator.of(context).pushNamedAndRemoveUntil("/Home", (route) => false),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _itemList(context, index) {
    return InkWell(
      onTap: () {
        setState(() {
          activeItems[index] = !activeItems[index];
        });
      },
      child: Column(
        children: [
          Image.asset(
              Assets.icSuckMilk,
              width: MediaQuery.of(context).size.width * (80 / 375),
              height: MediaQuery.of(context).size.height * (150 / 812),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 10,
                child: Checkbox(value: activeItems[index], onChanged: (value) {
                  setState(() {
                    activeItems[index] = value;
                  });
                }),
              ),
              SizedBox(width: 10,),
              Text("Feeding ${index + 1}"),
            ],
          ),
        ],
      ),
    );
  }

}
