import 'package:epic/module/deily-intake.dart';
import 'package:epic/utils/assets.dart';
import 'package:epic/utils/constant.dart';
import 'package:epic/utils/firebase_manager.dart';
import 'package:epic/widgets/btn_main.dart';
import 'package:flutter/material.dart';

class ResultMilk extends StatefulWidget {
  @override
  _ResultMilkState createState() => _ResultMilkState();
}

class _ResultMilkState extends State<ResultMilk> {
  //Define name of formula in each feeding as string
  String nameMilkCommercial;
  String nameMilkMedicinal;
//Define name of formula in each feeding as string
  int scoopsMilkCommercial;
  int scoopsMilkMedicinal;

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
                      "Result 1/2",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      Assets.imgPic,
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
                              "In small bottle add:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${scoopsMilkCommercial.toString()} ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Text(
                                      "Scoops from ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      nameMilkCommercial == null
                                          ? ""
                                          : nameMilkCommercial,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${scoopsMilkMedicinal.toString()} ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Text(
                                      "Scoops from ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      nameMilkMedicinal == null
                                          ? ""
                                          : nameMilkMedicinal,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color:
                                              Theme.of(context).primaryColor),
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
                          action: () =>
                              Navigator.of(context).pushNamed("/ResultTwo"),
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

//method to calculate mixed formula (Commercial and medical )
  _calcResults() async {
    DeilyIntakeModel deilyIntake =
        await FirebaseManger.shard.getDailyIntake().first;
//Define variable of Nutrient composition of commercial formula
    double valCommercial;
    double leuCommercial;
    double proteinCommercial;
//Define variable of Nutrient composition of medical formula
    double proKeto;
    double proteinKeto;
    double energyKeto;

    //////// Calculate commerical milk using switch
    switch (deilyIntake.commercialMilk) {
      case MilkType.NAN1:
        valCommercial = (100 * double.parse(deilyIntake.val)) / 53.6;
        leuCommercial = (100 * double.parse(deilyIntake.leu)) / 106.4;
        proteinCommercial = (12.3 * valCommercial) / 100;
        setState(() {
          nameMilkCommercial = "Nan 1";
          scoopsMilkCommercial = leuCommercial ~/ 5;
        });
        break;
      case MilkType.SIMILAC:
        valCommercial = (100 * double.parse(deilyIntake.val)) / 641;
        leuCommercial = (100 * double.parse(deilyIntake.leu)) / 1079;
        proteinCommercial = (10.83 * valCommercial) / 100;
        setState(() {
          nameMilkCommercial = "Similac";
          scoopsMilkCommercial = leuCommercial ~/ 5;
        });
        break;
      case MilkType.APTAMIL:
        valCommercial = (100 * double.parse(deilyIntake.val)) / 520;
        leuCommercial = (100 * double.parse(deilyIntake.leu)) / 1020;
        proteinCommercial = (4.7 * valCommercial) / 100;
        setState(() {
          nameMilkCommercial = "Aptamil";
          scoopsMilkCommercial = leuCommercial ~/ 5;
        });
        break;
    }
    //////// Calculate Medical milk using switch
    switch (deilyIntake.medicinalMilk) {
      case MilkType.KETONEX:
        proKeto = (proteinCommercial - double.parse(deilyIntake.protein)).abs();
        proteinKeto = (100 * proKeto) / 15;
        energyKeto = (480 * proteinKeto) / 100;
        setState(() {
          nameMilkMedicinal = "Ketonex";
          scoopsMilkMedicinal = proteinKeto ~/ 5;
        });
        break;
      case MilkType.ANAMIX:
        proKeto = (proteinCommercial - double.parse(deilyIntake.protein)).abs();
        proteinKeto = (100 * proKeto) / 13.1;
        energyKeto = (466 * proteinKeto) / 100;
        setState(() {
          nameMilkMedicinal = "Anamix";
          scoopsMilkMedicinal = proteinKeto ~/ 5;
        });
        break;
      case MilkType.COMIDA:
        proKeto = (proteinCommercial - double.parse(deilyIntake.protein)).abs();
        proteinKeto = (100 * proKeto) / 12;
        energyKeto = (205 * proteinKeto) / 100;
        setState(() {
          nameMilkMedicinal = "Comida";
          scoopsMilkMedicinal = proteinKeto ~/ 5;
        });
        break;
    }
  }
}
