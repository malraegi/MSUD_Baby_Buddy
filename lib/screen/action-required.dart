import 'package:epic/screen/select_formula_page.dart';
import 'package:epic/utils/assets.dart';
import 'package:epic/widgets/btn_main.dart';
import 'package:flutter/material.dart';

class ActionRequired extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * (120 / 812),
            ),
            Text("Action Required", style: TextStyle(color: Colors.red, fontSize: 22, fontWeight: FontWeight.bold),),
            SizedBox(
              height: 30,
            ),
            Image.asset(
              Assets.imgSad,
              width: MediaQuery.of(context).size.width * (140 / 375),
              height: MediaQuery.of(context).size.width * (140 / 375),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Dear Mom,", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Your baby’s Leucine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                      Row(
                        children: [
                          Text("value is ", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                          Text("above normal", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.red),),
                        ],
                      ),
                    ],
                  ),
                  Text("Refer to your dietician\nas soon as possible", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * (80 / 812),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                btnMain(
                    title: "Close",
                    isBlack: true,
                    action: () => Navigator.of(context).pushNamed("/SelectFormulaPage", arguments: FormulaTypePage.COMMERCIAL),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
