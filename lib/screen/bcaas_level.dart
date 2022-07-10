import 'package:epic/styles/customStyles.dart';
import 'package:epic/utils/assets.dart';
import 'package:epic/utils/firebase_manager.dart';
import 'package:epic/widgets/btn_main.dart';
import 'package:epic/widgets/custom_input_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:epic/widgets/loader.dart';
import 'package:epic/utils/extensions.dart';

class BcaasLevel extends StatefulWidget {
  @override
  _BcaasLevelState createState() => _BcaasLevelState();
}

class _BcaasLevelState extends State<BcaasLevel> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey();

  String leucine;
  String isoleuocine;
  String valine;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.bgMainBackground),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * (154 / 812),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter plasma BCAAs Level",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      SizedBox(
                        height:
                        MediaQuery.of(context).size.height * (30 / 812),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: _formPage(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  btnMain(
                      title: "Next",
                      action: _btnNext),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _formPage() {
    return Column(
      children: [
        customInputFormWidget(context,
            title: "Leucine in(mcg)",
            input: TextFormField(
              onSaved: (value) => leucine = value,
              keyboardType: TextInputType.number,
              decoration: customInputForm,
            )),
        SizedBox(
          height: 20,
        ),
        customInputFormWidget(context,
            title: "Isoleuocine in(mcg)",
            input: TextFormField(
              onSaved: (value) => isoleuocine = value,
              keyboardType: TextInputType.number,
              decoration: customInputForm,
            )),
        SizedBox(
          height: 20,
        ),
        customInputFormWidget(context,
            title: "Valine in(mcg)",
            input: TextFormField(
              onSaved: (value) => valine = value,
              keyboardType: TextInputType.number,
              decoration: customInputForm,
            )),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _btnNext() async {

    _formKey.currentState.save();
    if (leucine == "" || isoleuocine == "" || valine == "") {
      _scaffoldKey.showTosta(message: "Please fill in all fields", isError: true);
      return;
    }

    showLoaderDialog(context);
    await FirebaseManger.shard.addBcaa(context, scaffoldKey: _scaffoldKey, leucine: leucine, isoleuocine: isoleuocine, valine: valine);
    showLoaderDialog(context, isShowLoader: false);

  }

}
