// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';

class itemsElements {
  String? orderID;
  String? itemName;
  String? itemPrice;
  String? itemCount;
  String? userName;
  String? userAddress;
  String? userEmail;
  String? userContact;

  itemsElements({
    this.orderID,
    this.userName,
    this.userEmail,
    this.userAddress,
    this.itemName,
    this.itemCount,
    this.itemPrice,
    this.userContact,
  });
}
