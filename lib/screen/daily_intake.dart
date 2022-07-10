import 'package:epic/module/deily-intake.dart';
import 'package:epic/screen/select_formula_page.dart';
import 'package:epic/utils/assets.dart';
import 'package:epic/utils/firebase_manager.dart';
import 'package:epic/widgets/btn_main.dart';
import 'package:flutter/material.dart';

class DailyIntake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.bgMainBackground),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 120,
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
            StreamBuilder<DeilyIntakeModel>(
                //daily intake streams
                stream: FirebaseManger.shard //retrieving info from firebase
                    .getDailyIntake(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    DeilyIntakeModel data = snapshot.data;

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            //daily intake container
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              // retrieving BCAA from firebase
                              children: [
                                Text(
                                  "Your Baby needs per day of",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      (70 / 812),
                                ),
                                Form(
                                  child: Column(
                                    //retrieve BCAA data from firebase
                                    children: [
                                      _itemForm(
                                          title: "Protein (gm):",
                                          value: "${data.protein}"),
                                      _itemForm(
                                          title: "Energy(kal):",
                                          value: "${data.energy}"),
                                      _itemForm(
                                          title: "Fluid(ml):",
                                          value: "${data.fluid}"),
                                      _itemForm(
                                          title: "Leucine in(ml):",
                                          value: "${data.leu}"),
                                      _itemForm(
                                          title: "Isoleuocine in (mg)",
                                          value: "${data.ile}"),
                                      _itemForm(
                                          title: "Valine",
                                          value: "${data.val}",
                                          isShowUnderLine: false),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              //next button
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                btnMain(
                                    title: "Next",
                                    action: () {
                                      if (double.parse(data.leu) >= 600.0 &&
                                          double.parse(data.leu) <= 800.0) {
                                        // if Leucine values are too high.
                                        Navigator.of(context)
                                            .pushNamed("/ActionRequired");
                                      } else {
                                        // navigate to formula selecting page.
                                        Navigator.of(context).pushNamed(
                                            "/SelectFormulaPage",
                                            arguments:
                                                FormulaTypePage.COMMERCIAL);
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Container(
                          width:
                              MediaQuery.of(context).size.width * (100 / 375),
                          height:
                              MediaQuery.of(context).size.width * (100 / 375),
                          padding: EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: CircularProgressIndicator()),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  _itemForm(
      {@required String title,
      String value = "",
      bool isShowUnderLine = true}) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                    width: 100,
                    child: Text(
                      title,
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(
                      child: Text(value),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
            //lines of scroll view
            visible: isShowUnderLine,
            child: Container(
              height: 1,
              color: Colors.black38,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
