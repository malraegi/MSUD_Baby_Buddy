import 'package:epic/styles/customStyles.dart';
import 'package:epic/utils/assets.dart';
import 'package:epic/utils/firebase_manager.dart';
import 'package:epic/widgets/btn_main.dart';
import 'package:epic/widgets/custom_input_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:epic/widgets/loader.dart';
import 'package:epic/utils/extensions.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //set login keys
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey();
  //set temp variables for email and password
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        //background container
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
                //styling
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * (30 / 812),
                      ),
                    ],
                  ),
                  Form(
                      //save results within a form key
                      key: _formKey,
                      child: _formPage() //view form method ,
                      ),
                ],
              ),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => {},
                      child: Container(
                        //google icon
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => {},
                      child: Container(
                        //Facebook icon
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
                            "New Here?",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacementNamed(
                                context, "/Signup"),
                            child: Text(
                              "Register",
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
                    title: "Login",
                    action: () => _btnLogin(context),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _formPage() {
    return Column(
      //form fields
      children: [
        customInputFormWidget(context,
            title: "Email",
            input: TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => email = value,
              decoration: customInputForm,
            )),
        SizedBox(
          height: 20,
        ),
        customInputFormWidget(context,
            title: "Password",
            input: TextFormField(
              onSaved: (value) => password = value,
              decoration: customInputForm,
              obscureText: true,
            )),
        Align(
            alignment: Alignment.topRight,
            child: FlatButton(
                onPressed: () => {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Color.fromRGBO(47, 128, 237, 1), fontSize: 14),
                )))
      ],
    );
  }

  _btnLogin(context) async {
    //login functions
    _formKey.currentState.save();
    if (email == "" || password == "") {
      //null case
      _scaffoldKey.showTosta(
          message: "Please fill in all fields", isError: true);
      return;
    }

    showLoaderDialog(context); //fire base loting manager
    await FirebaseManger.shard
        .login(scaffoldKey: _scaffoldKey, email: email, password: password)
        .then((success) => {
              showLoaderDialog(context, isShowLoader: false),
              if (success)
                {
                  // navigate to the bcaas
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/BcaasLevel', (Route<dynamic> route) => false),
                }
            });
  }
}
