import 'package:epic/module/deily-intake.dart';
import 'package:epic/utils/assets.dart';
import 'package:epic/utils/firebase_manager.dart';
import 'package:epic/widgets/btn_main.dart';
import 'package:flutter/material.dart';

class ResultTwo extends StatefulWidget {
  @override
  _ResultTwoState createState() => _ResultTwoState();
}

class _ResultTwoState extends State<ResultTwo> {
  String scoops;
  int mlOfWater;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calcResults();
  }

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
            SizedBox(
              height: 30,
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
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (60 / 812),
                    ),
                    Text(
                      "Result 2/2",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      Assets.icSuckMilk,
                      width: MediaQuery.of(context).size.width * (140 / 375),
                      height: MediaQuery.of(context).size.width * (140 / 375),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${scoops.toString()} ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Text(
                                      "Scoops (5 g)",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${mlOfWater.toString()} ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Text(
                                      "ml of warm water",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${8} ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Text(
                                      "times a day every ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      "${3} ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Text(
                                      "hours ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (40 / 812),
                    ),
                    Row(
                      children: [
                        Text(
                          "Note: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.red),
                        ),
                        Text(
                          "each scoop is 5 g ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (40 / 812),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        btnMain(
                          title: "Next",
                          action: () => Navigator.of(context)
                              .pushNamedAndRemoveUntil(
                                  "/Home", (route) => false),
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

//method to calculate feeding per day based on fluid of baby and weight
  _calcResults() async {
    DeilyIntakeModel deilyIntake =
        await FirebaseManger.shard.getDailyIntake().first;
//define variable fluid with weight (from daily intake page) divide 5g (the scoops)
    int feeding = double.parse(deilyIntake.fluid) ~/ 5;
//make if statement based on feeding of the baby to display
// how many ml and scoops per day for the baby
    if (feeding == 25) {
      setState(() {
        scoops = "3 / 4";
        mlOfWater = 25;
      });
    } else if (feeding == 30) {
      setState(() {
        scoops = "1";
        mlOfWater = 30;
      });
    } else if (feeding == 40) {
      setState(() {
        scoops = "1 1/4";
        mlOfWater = 40;
      });
    } else if (feeding == 60) {
      setState(() {
        scoops = "2";
        mlOfWater = 60;
      });
    } else if (feeding == 100) {
      setState(() {
        scoops = "3";
        mlOfWater = 100;
      });
    } else if (feeding == 120) {
      setState(() {
        scoops = "3";
        mlOfWater = 120;
      });
    } else if (feeding == 160) {
      setState(() {
        scoops = "5";
        mlOfWater = 160;
      });
    } else if (feeding == 180) {
      setState(() {
        scoops = "6";
        mlOfWater = 180;
      });
    }
  }
}
