import 'package:achievement_view/achievement_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projects/Firebase/mechanicController/mechanicAuth.dart';
import 'package:projects/Firebase/mechanicController/mechanicSigninController.dart';
import 'package:projects/Views/Authentication/forgotPass.dart';
import 'package:projects/Views/Authentication/mehcanicSignUp.dart';
import 'package:projects/Widgets/Authentication/loginTextField.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class mechanicSignin extends StatelessWidget {
  RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  mechanicSigninController signinController = mechanicSigninController();
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
                  fieldController: signinController.emailController,
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
                  fieldController: signinController.passwordController,
                  fieldIcon: Icons.password,
                  fieldText: "Enter your password",
                  fieldIcon2: Icons.visibility_off,
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
                      if (signinController.passwordController.text.isNotEmpty &&
                          signinController.emailController.text.isNotEmpty) {
                        mechanicAuth().loggingIn(
                          signinController.emailController.text,
                          signinController.passwordController.text,
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
                              child: mechanicSignup(),
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
