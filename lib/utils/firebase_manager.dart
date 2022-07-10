import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epic/module/deily-intake.dart';
import 'package:epic/module/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:epic/utils/extensions.dart';

import 'constant.dart';

class FirebaseManger {

  static final FirebaseManger shard = FirebaseManger();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference userRef = FirebaseFirestore.instance.collection('User');
  final CollectionReference dailyIntakeRef = FirebaseFirestore.instance.collection('DailyIntake');

  Future<String> _createAccountInFirebase({GlobalKey<ScaffoldState> scaffoldKey, String email, String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        scaffoldKey.showTosta(message: "the email is already used", isError: true);
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  createAccountUser (
      context,
      {
        @required GlobalKey<ScaffoldState> scaffoldKey,
        @required String fullName,
        @required String email,
        @required String password,
        @required String age,
        @required String gender,
        @required String height,
        @required String weight,
      }) async {

    if (!email.isValidEmail()) {
      scaffoldKey.showTosta(message: "يرجى إدخال إيميل صحيح", isError: true);
      return;
    }

    var userId = await _createAccountInFirebase(scaffoldKey: scaffoldKey, email: email, password: password);
    if (userId != null) {
      userRef.doc(userId).set({
            "email": email,
            "full-name": fullName,
            "age": age,
            "gender": gender,
            "height": height,
            "weight": weight,
            "user-id": userId,
      })
          .then((value) {
        Navigator.pushReplacementNamed(context, "/Login");
      })
          .catchError((err) { scaffoldKey.showTosta(message: "Something went wrong", isError: true); });
    }

  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult result = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final FacebookAuthCredential facebookAuthCredential =
  //   FacebookAuthProvider.credential(result.accessToken.token);
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }

  Future<bool> login({ @required GlobalKey<ScaffoldState> scaffoldKey, @required String email, @required String password }) async {

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        scaffoldKey.showTosta(message: "user not found", isError: true);
      } else if (e.code == 'wrong-password') {
        scaffoldKey.showTosta(message: "wrong password", isError: true);
      } else if (e.code == 'too-many-requests') {
        scaffoldKey.showTosta(message: "The account is temporarily locked", isError: true);
      }
    }
    return false;
  }

  addBcaa(context, { @required GlobalKey<ScaffoldState> scaffoldKey, @required String leucine, @required String isoleuocine, @required String valine }) {
    userRef.doc(auth.currentUser.uid).update({
      "leucine": leucine,
      "isoleuocine": isoleuocine,
      "valine": valine,
    }).then((_) => {
      Navigator.of(context).pushNamed("/DailyIntake")
    }).catchError((e) {
      scaffoldKey.showTosta(message: "Something went wrong", isError: true);
    });
  }

  TUser _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return TUser.fromJson(snapshot.data());
  }
  
  Stream<TUser> get user {
     return userRef.doc(auth.currentUser.uid).snapshots().map(_userDataFromSnapshot);
  }
  
  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (_) {
      return false;
    }
  }

  addDailyIntake({ @required String ILE, @required String LEU, @required String VAL, @required String protein, @required String energy, @required String fluid }) {
    dailyIntakeRef.doc(auth.currentUser.uid).set({
      "ILE": ILE,
      "LEU": LEU,
      "VAL": VAL,
      "protein": protein,
      "energy": energy,
      "fluid": fluid,
      "commercial-milk": -1,
      "medicinal-milk": -1,
    }).then((_) => {

    }).catchError((e) {

    });

  }

  updateCommercialMilk({ @required MilkType milkType }) {
    dailyIntakeRef.doc(auth.currentUser.uid).update({
      "commercial-milk": milkType.index,
    }).then((_) {

    }).catchError((e) {

    });
  }

  updateMedicinalMilk({ @required MilkType milkType }) {
    dailyIntakeRef.doc(auth.currentUser.uid).update({
      "medicinal-milk": milkType.index,
    }).then((_) {

    }).catchError((e) {

    });
  }

  Future<bool> checkExistDailyIntake() async {
    DocumentSnapshot snapshot = await dailyIntakeRef.doc(auth.currentUser.uid).get();
    return snapshot.data() != null;
  }

  Stream<DeilyIntakeModel> getDailyIntake() {

    return dailyIntakeRef.doc(auth.currentUser.uid).snapshots().map((DocumentSnapshot snapshot) {
      return DeilyIntakeModel.fromJson(snapshot.data());
    });

  }

}