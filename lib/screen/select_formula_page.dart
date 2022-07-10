import 'package:epic/utils/assets.dart';
import 'package:epic/utils/constant.dart';
import 'package:epic/utils/firebase_manager.dart';
import 'package:epic/widgets/alert.dart';
import 'package:epic/widgets/btn_main.dart';
import 'package:flutter/material.dart';

enum FormulaTypePage {
  COMMERCIAL,
  MEDICAL,
}

class SelectFormulaPage extends StatefulWidget {
  final FormulaTypePage pageType;
  const SelectFormulaPage({Key key, this.pageType}) : super(key: key);

  @override
  _SelectFormulaPageState createState() => _SelectFormulaPageState();
}

class _SelectFormulaPageState extends State<SelectFormulaPage> {
  MilkType itemGroup;

  List<MilkType> items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch (widget.pageType) {
      case FormulaTypePage.COMMERCIAL:
        items = [MilkType.NAN1, MilkType.SIMILAC, MilkType.APTAMIL];
        break;
      case FormulaTypePage.MEDICAL:
        items = [MilkType.KETONEX, MilkType.ANAMIX, MilkType.COMIDA];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
            SizedBox(
              height: 20,
            ),
            Text(
              "Please select your formula\ntype",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              color: Colors.grey,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.6,
                  children: List.generate(items.length, (index) {
                    return _checkImage(index: index);
                  }),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                btnMain(title: "Next", action: _btnNext),
              ],
            ),
          ],
        ),
      ),
    );
  }

//Message error if the user doesn't select any formula
  _btnNext() {
    if (itemGroup == null) {
      showAlertDialog(context,
          title: "error",
          message: "Please choose milk",
          showBtnOne: false, actionBtnTwo: () {
        Navigator.of(context).pop();
      });
      return;
    }

    switch (widget.pageType) {
      case FormulaTypePage.COMMERCIAL:
        FirebaseManger.shard.updateCommercialMilk(milkType: itemGroup);
        Navigator.pushNamed(context, "/SelectFormulaPage",
            arguments: FormulaTypePage.MEDICAL);
        break;
      case FormulaTypePage.MEDICAL:
        FirebaseManger.shard.updateMedicinalMilk(milkType: itemGroup);
        Navigator.pushNamed(context, "/ResultMilk");
        break;
    }
  }

  _checkImage({int index}) {
    String image = "";

    switch (items[index]) {
      case MilkType.NAN1:
        image = Assets.imgNan1;
        break;
      case MilkType.SIMILAC:
        image = Assets.imgSimilac;
        break;
      case MilkType.APTAMIL:
        image = Assets.imgAptamil;
        break;
      case MilkType.KETONEX:
        image = Assets.imgKetonex;
        break;
      case MilkType.ANAMIX:
        image = Assets.imgAnamix;
        break;
      case MilkType.COMIDA:
        image = Assets.imgComida;
        break;
    }
//style each image
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width * (250 / 375),
      height: MediaQuery.of(context).size.height * (350 / 812),
      child: GestureDetector(
        onTap: () {
          setState(() {
            itemGroup = items[index];
          });
        },
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * (200 / 812),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
            Radio(
              groupValue: itemGroup,
              value: items[index],
              onChanged: (value) {
                setState(() {
                  itemGroup = items[index];
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
