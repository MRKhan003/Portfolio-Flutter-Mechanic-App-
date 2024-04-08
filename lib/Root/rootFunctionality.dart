import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projects/Firebase/myUser.dart';
import 'package:projects/Firebase/userController/userAuth.dart';
import 'package:projects/Screens/User_Screens/homeScreen.dart';
import 'package:projects/Views/Authentication/login.dart';
import 'package:projects/Views/Authentication/signup.dart';
import 'package:provider/provider.dart';

enum authentication {
  loggedIn,
  authenticating,
  notLoggedIn,
}

// ignore: must_be_immutable
class rootFunc extends StatefulWidget {
  @override
  State<rootFunc> createState() => _rootFuncState();
}

class _rootFuncState extends State<rootFunc> {
  authentication auth = authentication.authenticating;

  @override
  Widget build(BuildContext context) {
    userAuth controll = userAuth();
    controll = Provider.of<userAuth>(
      context,
      listen: false,
    );
    return FutureBuilder(
      future: null,
      builder: (context, snapshot) {
        if (controll.currentUser.userEmail == null) {
          auth = authentication.notLoggedIn;
        }
        if (controll.currentUser.userEmail != null) {
          if (controll.currentUser.userName != null) {
            auth = authentication.loggedIn;
          }
        }
        switch (auth) {
          case authentication.notLoggedIn:
            return userLogin();
          case authentication.loggedIn:
            return homeScreen();
          default:
            return signUpForm();
        }
      },
    );
  }
}
