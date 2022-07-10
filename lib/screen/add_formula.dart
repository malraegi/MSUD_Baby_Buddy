import 'package:epic/screen/select_formula_page.dart';
import 'package:epic/utils/assets.dart';
import 'package:epic/utils/constant.dart';
import 'package:epic/widgets/btn_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddFormula extends StatefulWidget {

  @override
  _AddFormulaState createState() => _AddFormulaState();
}

class _AddFormulaState extends State<AddFormula> {

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
            SizedBox(height: 10,),
            Row(
              children: [
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios, color: Color.fromRGBO(11, 127, 254, 1),),
                      Text("Back", style: TextStyle(color: Color.fromRGBO(11, 127, 254, 1),),),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * (120 / 812),),
            Column(
              children: [
                Text("Add your formula", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                SizedBox(height: MediaQuery.of(context).size.height * (60 / 812),),
                Icon(Icons.camera_alt, color: Colors.black,),
                SizedBox(height: MediaQuery.of(context).size.height * (20 / 812),),
                RaisedButton(onPressed: () {}, child: Text("Scan the barcode", style: TextStyle(color: Colors.white),), color: Theme.of(context).accentColor,),
                SizedBox(height: 10),
                Text("Or", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                SizedBox(height: 10),
                RaisedButton(onPressed: () {}, child: Text("Scan the barcode", style: TextStyle(color: Colors.white),), color: Theme.of(context).accentColor,),
              ],
            ),
            Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                btnMain(title: "Next", action: () => Navigator.pushNamed(context, "/SelectFormulaPage", arguments: FormulaTypePage.COMMERCIAL)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
