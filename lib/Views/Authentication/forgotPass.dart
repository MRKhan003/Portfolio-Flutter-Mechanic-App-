import 'package:achievement_view/achievement_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projects/Firebase/userController/forgotPasswordController.dart';
import 'package:projects/Views/Authentication/login.dart';
import 'package:projects/Widgets/Authentication/loginTextField.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class forgotPass extends StatelessWidget {
  RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  forgotPassControl control = forgotPassControl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/images/forgotPassword.jpg",
                filterQuality: FilterQuality.high,
                height: 200,
                alignment: Alignment.topCenter,
              ),
            ),
            Container(
              child: Text(
                "Trouble with logging in?",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 1,
                  letterSpacing: 1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                left: 35,
                right: 35,
              ),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Enter your username or email address and we will send you a link to get back into your account.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    wordSpacing: 1,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 15,
              ),
              child: authLoginField(
                fieldController: control.emailControl,
                fieldIcon: Icons.email,
                fieldText: "Enter username or email",
                iconAndTextColor: Colors.black,
                iconSize: 20,
                textSize: 18,
                hideInput: false,
                textType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RoundedLoadingButton(
              controller: _buttonController,
              successColor: Colors.green,
              errorColor: Colors.red,
              duration: Duration(seconds: 3),
              resetDuration: Duration(seconds: 5),
              resetAfterDuration: true,
              onPressed: () {
                if (control.emailControl.text.isNotEmpty) {
                  sendEmail(control.emailControl.text);
                } else {
                  AchievementView(
                      title: "Error!",
                      subTitle: "Enter your email address",
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
                "Send",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 90,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                child: Text(
                  "Back to login",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: userLogin(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> sendEmail(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    print('Check your email for other steps');
    Fluttertoast.showToast(
      msg: 'Check your email for other steps',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return true;
  } on FirebaseAuthException catch (e) {
    print("$e");
    Fluttertoast.showToast(
      msg: '$e',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    return false;
  }
}
