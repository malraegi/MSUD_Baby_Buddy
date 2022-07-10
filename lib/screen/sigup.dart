import 'package:epic/styles/customStyles.dart';
import 'package:epic/utils/assets.dart';
import 'package:epic/utils/firebase_manager.dart';
import 'package:epic/widgets/btn_main.dart';
import 'package:epic/widgets/custom_input_form_widget.dart';
import 'package:epic/widgets/drop_down_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:epic/utils/extensions.dart';
import 'package:epic/widgets/loader.dart';

enum ActivePage { pageOne, pageTwo }

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  ActivePage activePage = ActivePage.pageOne;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  String fullName;
  String email;
  String password;
  String age;
  String gender;
  String height;
  String weight;

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
            //register column
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * (154 / 812),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Visibility(
                      visible: activePage == ActivePage.pageOne,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * (30 / 812),
                          ),
                        ],
                      )),
                  Form(
                    child: Column(
                      children: [
                        Visibility(
                            visible: activePage == ActivePage.pageOne,
                            child: _formPageOne()),
                        Visibility(
                            visible: activePage == ActivePage.pageTwo,
                            child: _formPageTwo()),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Already Member?",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            //navigation to login page
                            onTap: () => Navigator.pushReplacementNamed(
                                context, "/Login"),
                            child: Text(
                              "Login",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  btnMain(
                      title: activePage ==
                              ActivePage.pageOne //if else advanced variation
                          ? "Next"
                          : "Register",
                      action: () => _btnRegister()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _formPageOne() {
    return Column(
      children: [
        customInputFormWidget(context,
            title: "Full Name",
            input: TextFormField(
              onChanged: (value) => fullName = value,
              decoration: customInputForm,
            )),
        SizedBox(
          height: 20,
        ),
        customInputFormWidget(context,
            title: "Email",
            input: TextFormField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => email = value,
              decoration: customInputForm,
            )),
        SizedBox(
          height: 20,
        ),
        customInputFormWidget(context,
            title: "Password",
            input: TextFormField(
              onChanged: (value) => password = value,
              decoration: customInputForm,
              obscureText: true,
            )),
        SizedBox(
          height: 20,
        ),
        Container(
          //Google Icon
          child: Row(
            children: [
              GestureDetector(
                onTap: () => {},
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 50,
                  height: 50,
                  child: Image.asset(Assets.icGoogle),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                //Facebook Icon
                onTap: () => {},
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 50,
                  height: 50,
                  child: Image.asset(Assets.icFacebook),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _formPageTwo() {
    List<String> agesItems = [
      "month",
      "2 months",
      "3 months",
      "4 months",
      "5 months",
      "6 months"
    ];

    List<String> genderItems = ["Male", "Female"];

    return Column(
      //Fields
      children: [
        dropDownAuth(context,
            title: "Age",
            hintText: "Choose age",
            items: agesItems, onChange: (value) {
          age = value;
        }),
        SizedBox(
          height: 20,
        ),
        dropDownAuth(context,
            title: "Gender",
            hintText: "Choose gender",
            items: genderItems, onChange: (value) {
          gender = value;
        }),
        SizedBox(
          height: 20,
        ),
        customInputFormWidget(context,
            title: "Height in (cm)",
            input: TextFormField(
              onChanged: (value) => height = value,
              keyboardType: TextInputType.number,
              decoration: customInputForm,
            )),
        SizedBox(
          height: 20,
        ),
        customInputFormWidget(context,
            title: "Weight in (kg)",
            input: TextFormField(
              onChanged: (value) => weight = value,
              keyboardType: TextInputType.number,
              decoration: customInputForm,
            ))
      ],
    );
  }

  _btnRegister() async {
    //Validation using switch if the user doesn't fill the field
    switch (activePage) {
      case ActivePage.pageOne:
        if (fullName == null ||
            fullName == "" ||
            email == null ||
            email == "" ||
            password == null ||
            password == "") {
          _scaffoldKey.showTosta(
              message: "Please fill in all fields", isError: true);
          return;
        }

        if (!email.isValidEmail()) {
          _scaffoldKey.showTosta(
              message: "Please enter a valid email", isError: true);
          return;
        }

        setState(() {
          activePage = ActivePage.pageTwo;
        });
        break;
      case ActivePage.pageTwo:
        if (age == null ||
            age == "" ||
            gender == null ||
            gender == "" ||
            height == null ||
            height == "" ||
            weight == null ||
            weight == "") {
          _scaffoldKey.showTosta(
              message: "Please fill in all fields", isError: true);
          return;
        }

        showLoaderDialog(context);
        await FirebaseManger.shard.createAccountUser(context,
            scaffoldKey: _scaffoldKey,
            fullName: fullName,
            email: email,
            password: password,
            age: age,
            gender: gender,
            height: height,
            weight: weight);
        showLoaderDialog(context, isShowLoader: false);

        break;
    }
  }
}
