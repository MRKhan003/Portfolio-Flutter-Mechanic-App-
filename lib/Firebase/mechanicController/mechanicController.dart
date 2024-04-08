import 'package:flutter/material.dart';
import 'package:projects/Firebase/mechanicController/mechanicAuth.dart';

class mechanicController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPassController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  mechanicAuth auth = mechanicAuth();
}
