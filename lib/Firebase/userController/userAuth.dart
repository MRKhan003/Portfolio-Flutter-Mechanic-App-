// ignore_for_file: unused_import

import 'package:achievement_view/achievement_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projects/Firebase/myUser.dart';
import 'package:projects/Firebase/userDatabase/userDatabase.dart';
import 'package:projects/Screens/User_Screens/homeScreen.dart';
import 'package:projects/Views/Authentication/login.dart';
import 'package:projects/Views/Authentication/signup.dart';

class userAuth with ChangeNotifier {
  myUser currentUser = myUser();
  FirebaseAuth auth = FirebaseAuth.instance;
  late bool exception;

  Future<bool> signUp(
      String email, String pass, String userName, String userCity) async {
    myUser user = myUser();
    try {
      UserCredential userAuth = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      if (userAuth.user != null) {
        exception = true;
        print("Data sent for authentication");
        user.userId = userAuth.user!.uid;
        user.userEmail = userAuth.user!.email;
        user.userPassword = pass;
        user.userName = userAuth.user!.displayName;
        user.userCity = userAuth.user!.displayName;
      }
      print(exception);
      userDatabase().enterUsertoDatabase(user);

      return true;
    } on FirebaseAuthException catch (e) {
      exception = false;
      if (e.code == 'weak-password') {
        print(exception);
        print('The password provided is too weak.');
        Fluttertoast.showToast(
          msg: 'The password provided is too weak.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return false;
      } else if (e.code == 'email-already-in-use') {
        print(exception);
        print('The account already exists for that email.');
        Fluttertoast.showToast(
          msg: 'The account already exists for that email.',
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

  //final bool exception1 = exception;
  Future<bool> loggingIn(
      String email, String pass, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      // ignore: unused_local_variable
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      if (userCredential.user != null) {
        currentUser =
            await userDatabase().getUserByID(userCredential.user!.uid);
        print(currentUser.userEmail);
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
      navigateToNextScreenAfterLogin(context);
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
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

void navigateToNextScreenAfterLogin(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => homeScreen()),
  );
}
