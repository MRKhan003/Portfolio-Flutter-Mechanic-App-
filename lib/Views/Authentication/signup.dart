// ignore_for_file: must_be_immutable

import 'package:achievement_view/achievement_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projects/Firebase/myUser.dart';
import 'package:projects/Firebase/userController/signUpController.dart';
import 'package:projects/Firebase/userDatabase/userDatabase.dart';
import 'package:projects/Views/Authentication/login.dart';
import 'package:projects/Views/Authentication/mehcanicSignUp.dart';
import 'package:projects/Widgets/Authentication/loginTextField.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

var temp;

class signUpForm extends StatelessWidget {
  RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  signupControl control = signupControl();
  myUser user = myUser();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        elevation: 1,
        title: Text(
          "Signup to create profile",
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
        child: Padding(
          padding: const EdgeInsets.only(
            left: 40,
            right: 40,
            top: 10,
          ),
          child: Column(
            children: [
              GestureDetector(
                onDoubleTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: mechanicSignup(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                child: Container(
                  child: Text(
                    "Want to earn?",
                  ),
                  alignment: Alignment.topRight,
                ),
              ),
              Image.asset(
                "assets/images/logo.png",
                height: 150,
                width: 100,
                filterQuality: FilterQuality.high,
              ),
              SizedBox(
                height: 10,
              ),
              authLoginField(
                fieldController: control.userNameController,
                fieldIcon: Icons.person,
                fieldText: "Enter your name",
                iconAndTextColor: Colors.black,
                iconSize: 24,
                textSize: 18,
                hideInput: false,
                textType: TextInputType.name,
              ),
              SizedBox(
                height: 10,
              ),
              authLoginField(
                fieldController: control.userCityController,
                fieldIcon: Icons.location_city,
                fieldText: "Enter your city",
                iconAndTextColor: Colors.black,
                iconSize: 24,
                textSize: 18,
                hideInput: false,
                textType: TextInputType.streetAddress,
              ),
              SizedBox(
                height: 10,
              ),
              authLoginField(
                fieldController: control.emailController,
                fieldIcon: Icons.email,
                fieldText: "Enter your email",
                iconAndTextColor: Colors.black,
                iconSize: 24,
                textSize: 18,
                hideInput: false,
                textType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 10,
              ),
              authLoginField(
                fieldController: control.passwordController,
                fieldIcon: Icons.password,
                fieldIcon2: Icons.visibility_off,
                fieldText: "Enter your password",
                iconAndTextColor: Colors.black,
                iconSize: 24,
                textSize: 18,
                hideInput: true,
                textType: TextInputType.visiblePassword,
              ),
              SizedBox(
                height: 10,
              ),
              authLoginField(
                fieldController: control.confirmPassController,
                fieldIcon: Icons.password,
                fieldIcon2: Icons.visibility_off,
                fieldText: "Confirm Password",
                iconAndTextColor: Colors.black,
                iconSize: 24,
                textSize: 18,
                hideInput: true,
                textType: TextInputType.visiblePassword,
              ),
              SizedBox(
                height: 10,
              ),
              Hero(
                tag: "auth",
                child: RoundedLoadingButton(
                  controller: _buttonController,
                  successColor: Colors.green,
                  errorColor: Colors.red,
                  duration: Duration(seconds: 3),
                  resetAfterDuration: true,
                  onPressed: () {
                    if (control.passwordController.text ==
                            control.confirmPassController.text &&
                        control.emailController.text.isNotEmpty &&
                        control.passwordController.text.isNotEmpty &&
                        control.userNameController.text.isNotEmpty &&
                        control.userCityController.text.isNotEmpty &&
                        control.userCityController.text.contains(
                          RegExp(r'[A-Z || a-z]'),
                        )) {
                      signUp(
                        control.emailController.text,
                        control.passwordController.text,
                        control.userNameController.text,
                        control.userCityController.text,
                        context,
                      );
                      user.userName = control.userNameController.text;
                      user.userEmail = control.emailController.text;
                      user.userCity = control.userCityController.text;
                      user.userPassword = control.passwordController.text;

                      userDatabase().enterUsertoDatabase(user);
                    } else {
                      AchievementView(
                          title: "Error!",
                          subTitle: "Fill complete information",
                          color: Colors.red,
                          duration: Duration(seconds: 5),
                          //isCircle: false,
                          listener: (status) {
                            print(status);
                          }).show(context);
                    }
                    Duration(seconds: 5);
                    // Navigator.pushReplacement(
                    //   context,
                    //   PageTransition(
                    //     child: userLogin(),
                    //     type: PageTransitionType.fade,
                    //   ),
                    // );
                  },
                  child: Text(
                    "Signup",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      child: Text(
                        "Signin",
                        style: GoogleFonts.poppins(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: userLogin(),
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
    );
  }
}

Future<bool> signUp(String email, String pass, String userName, String userCity,
    BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  try {
    // ignore: unused_local_variable
    UserCredential userAuth =
        await auth.createUserWithEmailAndPassword(email: email, password: pass);

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

void navigateToNextScreen(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => userLogin()),
  );
}
