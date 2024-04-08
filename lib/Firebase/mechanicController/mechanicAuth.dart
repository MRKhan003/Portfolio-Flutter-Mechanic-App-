import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projects/Firebase/MechanicDatabase/mechanicDatabase.dart';
import 'package:projects/Firebase/MechanicFolder/getOffer.dart';
import 'package:projects/Firebase/MechanicFolder/mechanicInfo.dart';
import 'package:projects/Screens/User_Screens/homeScreen.dart';
import 'package:projects/Views/Authentication/login.dart';
import 'package:projects/Views/Authentication/mechanicSignin.dart';

class mechanicAuth {
  mechanicInfo currentMechanic = mechanicInfo();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> registerMechanic(
      String email, String pass, BuildContext context) async {
    mechanicInfo mechanic = mechanicInfo();
    try {
      UserCredential authResult = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      Fluttertoast.showToast(
        msg: 'Account created successfully',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      navigateToNextScreen(context);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Fluttertoast.showToast(
          msg: 'The password provided is too weak.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return false;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Fluttertoast.showToast(
          msg: 'The account already exists for that email.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return false;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> loggingIn(
      String email, String pass, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    mechanicInfo currentMechanic = mechanicInfo();
    try {
      // ignore: unused_local_variable
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      if (userCredential.user != null) {
        currentMechanic =
            await mechanicDatabase().getUserByID(userCredential.user!.uid);
        print(currentMechanic.mechanicID);
      }
      Fluttertoast.showToast(
        msg: 'Successfully logged in',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      navigateToNextScreenAfterLogin(email, context);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        print('Invalid username or password');
        Fluttertoast.showToast(
          msg: 'Invalid username or password',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Fluttertoast.showToast(
          msg: 'Wrong password provided for that user.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return false;
      } else if (e.code ==
              'Failed to get document because the client is offline.' ||
          e.code == 'unavailable') {
        Fluttertoast.showToast(
          msg: 'Check your internet connection and try later.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return false;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

void navigateToNextScreenAfterLogin(String email, BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) => getOffer(
              email: email,
            )),
  );
}

void navigateToNextScreen(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => mechanicSignin()),
  );
}
