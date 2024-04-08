// import 'dart:ffi';

import 'dart:async';

import 'package:achievement_view/achievement_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projects/Firebase/userController/signinController.dart';
import 'package:projects/Firebase/userController/userAuth.dart';
import 'package:projects/Screens/User_Screens/homeScreen.dart';
import 'package:projects/Views/Authentication/forgotPass.dart';
import 'package:projects/Views/Authentication/signup.dart';
import 'package:projects/Widgets/Authentication/loginTextField.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

// ignore: must_be_immutable
class userLogin extends StatelessWidget {
  RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  signinControll controll = signinControll();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String? validateEmail(String? email) {
    if (email == null) {
      print("Invalid email");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        elevation: 1,
        title: Text(
          "Login to your profile",
          style: GoogleFonts.poppins(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 19,
            wordSpacing: 1,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 40,
              right: 40,
              top: 80,
            ),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 150,
                  width: 100,
                  filterQuality: FilterQuality.high,
                ),
                SizedBox(
                  height: 20,
                ),
                authLoginField(
                  fieldController: controll.emailController,
                  fieldIcon: Icons.email,
                  fieldText: "Enter your email",
                  iconAndTextColor: Colors.black,
                  iconSize: 24,
                  textSize: 18,
                  hideInput: false,
                  textType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                authLoginField(
                  fieldController: controll.passwordController,
                  fieldIcon: Icons.password,
                  fieldIcon2: Icons.visibility_off,
                  fieldText: "Enter your password",
                  iconAndTextColor: Colors.black,
                  iconSize: 24,
                  textSize: 18,
                  hideInput: true,
                  textType: TextInputType.visiblePassword,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 5,
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      child: Text(
                        "Forgot Password?",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: forgotPass(),
                            type: PageTransitionType.leftToRight,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Hero(
                  tag: "auth",
                  child: RoundedLoadingButton(
                    controller: _buttonController,
                    successColor: Colors.green,
                    errorColor: Colors.red,
                    duration: Duration(seconds: 3),
                    resetDuration: Duration(seconds: 5),
                    resetAfterDuration: true,
                    onPressed: () {
                      if (controll.passwordController.text.isNotEmpty &&
                          controll.emailController.text.isNotEmpty) {
                        userAuth().loggingIn(
                          controll.emailController.text,
                          controll.passwordController.text,
                          context,
                        );
                      } else {
                        AchievementView(
                            title: "Error!",
                            subTitle: "Fill complete information",
                            //content: Widget()
                            //onTab: _onTabAchievement,
                            //icon: Icon(Icons.insert_emoticon, color: Colors.white,),
                            //typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
                            //borderRadius: 5.0,
                            color: Colors.red,
                            //textStyleTitle: TextStyle(),
                            //textStyleSubTitle: TextStyle(),
                            //alignment: Alignment.topCenter,
                            duration: Duration(seconds: 5),
                            //isCircle: false,
                            listener: (status) {
                              print(status);
                              //AchievementState.opening
                              //AchievementState.open
                              //AchievementState.closing
                              //AchievementState.closed
                            }).show(context);
                      }
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New to this app?",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        child: Text(
                          "Signup",
                          style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: signUpForm(),
                              type: PageTransitionType.fade,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> loggingIn(String email, String pass, BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  try {
    // ignore: unused_local_variable
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: pass);
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

void navigateToNextScreenAfterLogin(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => homeScreen()),
  );
}
