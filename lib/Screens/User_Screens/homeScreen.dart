// ignore_for_file: unused_import

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projects/Firebase/myUser.dart';
import 'package:projects/Screens/User_Screens/bookMechanic.dart';
import 'package:projects/Screens/User_Screens/buyParts.dart';
import 'package:projects/Screens/User_Screens/customOffer.dart';
import 'package:projects/Views/Authentication/login.dart';
import 'package:projects/Widgets/bookMehcanic/drawerItem.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class homeScreen extends StatefulWidget {
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  myUser currentUser = myUser();
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  FirebaseAuth auth = FirebaseAuth.instance;

  List<IconData> icons = [
    FontAwesomeIcons.gauge,
    FontAwesomeIcons.motorcycle,
  ];
  int page = 0;
  int pageView = 0;
  PageController pageController = PageController(initialPage: 0);
  Widget pageViewsSection() {
    return PageView(
      controller: pageController,
      onPageChanged: (value) {
        setState(() {
          page = value;
        });
      },
      children: [
        bookMechanic(),
        buyParts(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Image.asset(
            "assets/images/logo.png",
            filterQuality: FilterQuality.high,
            width: 50,
            height: 50,
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onDoubleTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: customOffer(),
                    type: PageTransitionType.fade,
                  ),
                );
              },
              child: drawerItem(
                itemName: "Create custom offer",
                itemIcon: Icons.create,
              ),
            ),
            Divider(),
            RoundedLoadingButton(
              controller: buttonController,
              onPressed: () {
                Duration(milliseconds: 3);
                logout(context);
              },
              child: Text(
                "Logout",
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeColor: Colors.blue,
        inactiveColor: Colors.grey,
        gapLocation: GapLocation.center,
        leftCornerRadius: 10,
        rightCornerRadius: 10,
        borderColor: Colors.black,
        icons: icons,
        activeIndex: page,
        onTap: (p0) {
          setState(
            () {
              pageView = p0;
              pageController.animateToPage(
                p0,
                duration: Duration(milliseconds: 3),
                curve: Curves.linear,
              );
            },
          );
        },
      ),
      body: pageViewsSection(),
    );
  }
}

Future<bool> logout(BuildContext context) async {
  try {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: userLogin(),
        type: PageTransitionType.fade,
      ),
    );
    return true;
  } catch (e) {
    print("$e");
    return false;
  }
}
