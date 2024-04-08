//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class myUser {
  String? userId;
  String? userEmail;
  String? userPassword;
  String? userName;
  String? userCity;
  Timestamp? userCreate;

  myUser(
      {this.userId,
      this.userName,
      this.userEmail,
      this.userCity,
      this.userPassword,
      this.userCreate});
}
