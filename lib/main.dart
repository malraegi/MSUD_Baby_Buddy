import 'package:epic/screen/breastfeeding.dart';
import 'package:epic/screen/home.dart';
import 'package:epic/screen/action-required.dart';
import 'package:epic/screen/chat.dart';
import 'package:epic/screen/chat_menu.dart';
import 'package:epic/screen/daily_intake.dart';
import 'package:epic/screen/result-milk.dart';
import 'package:epic/screen/result-two.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:epic/screen/recommended_daily.dart';
import 'package:epic/screen/select_formula_page.dart';
import 'package:epic/screen/add_formula.dart';
import 'package:epic/screen/bcaas_level.dart';
import 'package:epic/screen/login.dart';
import 'package:epic/screen/sigup.dart';
import 'package:epic/screen/start_page.dart';
import 'package:epic/screen/tip.dart';
import 'package:epic/screen/tips-list.dart';
import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      title: 'Epic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Font Style in all app
        primaryColor: Color.fromRGBO(255, 164, 91, 1),
        accentColor: Color.fromRGBO(47, 128, 237, 1),
        fontFamily: 'NeoSansArabic',
      ),
      home: StartPage(),
      onGenerateRoute: (settings) {
        final arguments = settings.arguments;
        switch (settings.name) {
          case '/Signup':
            return MaterialPageRoute(builder: (_) => Signup());
          case '/Login':
            return MaterialPageRoute(builder: (_) => Login());
          case '/BcaasLevel':
            return MaterialPageRoute(builder: (_) => BcaasLevel());
          case '/AddFormula':
            return MaterialPageRoute(builder: (_) => AddFormula());
          case '/SelectFormulaPage':
            return MaterialPageRoute(
                builder: (_) => SelectFormulaPage(
                      pageType: arguments,
                    ));
          case '/RecommendedDaily':
            return MaterialPageRoute(builder: (_) => RecommendedDaily());
          case '/Home':
            return MaterialPageRoute(builder: (_) => Home());
          case '/ChatMenu':
            return MaterialPageRoute(builder: (_) => ChatMenu());
          case '/TipsList':
            return MaterialPageRoute(builder: (_) => TipsList());
          case '/Tip':
            return MaterialPageRoute(builder: (_) => Tip());
          case '/Chat':
            return MaterialPageRoute(builder: (_) => Chat());
          case '/DailyIntake':
            return MaterialPageRoute(builder: (_) => DailyIntake());
          case '/ActionRequired':
            return MaterialPageRoute(builder: (_) => ActionRequired());
          case '/ResultMilk':
            return MaterialPageRoute(builder: (_) => ResultMilk());
          case '/ResultTwo':
            return MaterialPageRoute(builder: (_) => ResultTwo());
          case '/feeding':
            return MaterialPageRoute(builder: (_) => Breastfeeding());
          default:
            return null;
        }
      },
    );
  }
}
