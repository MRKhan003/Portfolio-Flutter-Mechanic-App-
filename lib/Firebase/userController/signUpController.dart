import 'package:flutter/material.dart';
import 'package:projects/Firebase/userController/userAuth.dart';

class signupControl {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userCityController = TextEditingController();

  userAuth currentUser = userAuth();
}
