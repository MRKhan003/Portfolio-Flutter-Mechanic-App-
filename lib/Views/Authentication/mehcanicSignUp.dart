import 'package:achievement_view/achievement_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projects/Firebase/MechanicDatabase/mechanicDatabase.dart';
import 'package:projects/Firebase/MechanicFolder/mechanicInfo.dart';
import 'package:projects/Firebase/mechanicController/mechanicAuth.dart';
import 'package:projects/Firebase/mechanicController/mechanicController.dart';
import 'package:projects/Views/Authentication/login.dart';
import 'package:projects/Views/Authentication/mechanicSignin.dart';
import 'package:projects/Widgets/Authentication/loginTextField.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class mechanicSignup extends StatelessWidget {
  RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  mechanicController controller = mechanicController();
  mechanicInfo info = mechanicInfo();
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
        actions: [
          Image.asset(
            "assets/images/logo.png",
            filterQuality: FilterQuality.high,
            height: 200,
            width: 100,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 40,
            right: 40,
            top: 20,
          ),
          child: Column(
            children: [
              Container(
                child: Text(
                  "Mechanic profile creation",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              authLoginField(
                fieldController: controller.nameController,
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
                fieldController: controller.locationController,
                fieldIcon: Icons.location_city,
                fieldText: "Enter your address or shop address",
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
                fieldController: controller.contactController,
                fieldIcon: Icons.phone,
                fieldText: "Enter your contact number",
                iconAndTextColor: Colors.black,
                iconSize: 24,
                textSize: 18,
                hideInput: false,
                textType: TextInputType.phone,
              ),
              SizedBox(
                height: 10,
              ),
              authLoginField(
                fieldController: controller.emailController,
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
                fieldController: controller.passwordController,
                fieldIcon: Icons.password,
                fieldText: "Enter your password",
                fieldIcon2: Icons.visibility_off,
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
                fieldController: controller.cPassController,
                fieldIcon: Icons.password,
                fieldText: "Confirm Password",
                fieldIcon2: Icons.visibility_off,
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
                  resetDuration: Duration(seconds: 3),
                  resetAfterDuration: true,
                  onPressed: () {
                    Duration(
                      milliseconds: 3,
                    );
                    if (controller.passwordController.text ==
                            controller.cPassController.text &&
                        controller.emailController.text.isNotEmpty &&
                        controller.contactController.text.isNotEmpty &&
                        controller.locationController.text.isNotEmpty &&
                        controller.nameController.text.isNotEmpty &&
                        controller.passwordController.text.isNotEmpty &&
                        controller.cPassController.text.isNotEmpty) {
                      mechanicAuth().registerMechanic(
                          controller.emailController.text,
                          controller.passwordController.text,
                          context);
                      info.mechanciName = controller.nameController.text;
                      info.mechanicAddress = controller.locationController.text;
                      info.mechanicEmail = controller.emailController.text;
                      info.mechanicMobile = controller.contactController.text;
                      info.mechanicPassword =
                          controller.passwordController.text;
                      mechanicDatabase().sendUsertoDatabase(info);
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
                          //duration: Duration(seconds: 3),
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
                            child: mechanicSignin(),
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
