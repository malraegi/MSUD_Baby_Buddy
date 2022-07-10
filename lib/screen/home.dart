import 'package:epic/module/user.dart';
import 'package:epic/utils/assets.dart';
import 'package:epic/utils/firebase_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:epic/utils/extensions.dart';
import 'package:epic/widgets/loader.dart';

class Home extends StatelessWidget {
  // 6 nutrition protocol with an average of the babies from zero to six months
  List<double> ILE = [40, 48, 56, 48.5, 40.5, 47.5];
  List<double> LEU = [66.5, 79.5, 92.5, 56, 68, 80];
  List<double> VAL = [46.6, 55.5, 64.5, 56, 47, 55];
  List<double> protein = [3.45, 3.34, 3.16, 3, 2.84, 2.68];
  List<double> energy = [120, 120, 120, 120, 120, 120];
  List<double> fluid = [100, 100, 100, 100, 100, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<TUser>(
          stream: FirebaseManger.shard.user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              TUser userData = snapshot.data;

              int month = _convertMonthToNumber(userData.age) - 1;
              double weight = double.parse(userData.weight);
              // calculate recommended daily intake
              FirebaseManger.shard.checkExistDailyIntake().then((isExist) {
                if (!isExist) {
                  FirebaseManger.shard.addDailyIntake(
                    ILE: (ILE[month] * weight).toStringAsFixed(2),
                    LEU: (LEU[month] * weight).toStringAsFixed(2),
                    VAL: (VAL[month] * weight).toStringAsFixed(2),
                    protein: (protein[month] * weight).toStringAsFixed(2),
                    energy: (energy[month] * weight).toStringAsFixed(2),
                    fluid: (fluid[month] * weight).toStringAsFixed(2),
                  );
                }
              });

              return Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
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
                      height: MediaQuery.of(context).size.height * (120 / 812),
                    ),
                    Column(
                      children: [
                        Container(
                          width:
                              MediaQuery.of(context).size.width * (100 / 375),
                          height:
                              MediaQuery.of(context).size.width * (100 / 375),
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
                                size: 60,
                              )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Raghad",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (120 / 812),
                    ),
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: "2a58a1".toHexa(),
                          ),
                          child: GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushNamed("/DailyIntake"),
                              child: Text(
                                "My recommended daily\nintake",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                                textAlign: TextAlign.center,
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, "/TipsList"),
                              child: Column(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.lightbulb_outline,
                                      size: 60,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: "2a58a1".toHexa(),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Tips\n",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, "/ChatMenu"),
                              child: Column(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.chat_bubble,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: "2a58a1".toHexa(),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Chating with\nmy doctor",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: loader(context),
              );
            }
          }),
    );
  }

  _convertMonthToNumber(String month) {
    switch (month) {
      case "month":
        return 1;
      case "2 months":
        return 2;
      case "3 months":
        return 3;
      case "4 months":
        return 4;
      case "5 months":
        return 5;
      case "6 months":
        return 6;
    }
  }
}
