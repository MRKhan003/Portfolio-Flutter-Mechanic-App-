// ignore_for_file: unused_import

import 'package:achievement_view/achievement_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projects/Firebase/UserItems/itemsController.dart';
import 'package:projects/Firebase/UserItems/itemsElements.dart';

class userItemsDatabase {
  FirebaseFirestore ffObject = FirebaseFirestore.instance;

  Future<bool> sendDataToDatabase(
      itemsElements elements, BuildContext context) async {
    try {
      await ffObject.collection("User_Items").doc(elements.orderID).set({
        "UserName": elements.userName,
        "Phone_Number": elements.userContact,
        "UserEmail": elements.userEmail,
        "UserAddress": elements.userAddress,
        "ItemName": elements.itemName,
        "No_of_items": elements.itemCount,
        "TotalPrice": elements.itemPrice,
        "OrderTime": Timestamp.now(),
      });
      print("Data sent");
      AchievementView(
          title: "Congrats!",
          subTitle: "Order sent for confirmation",
          //content: Widget()
          //onTab: _onTabAchievement,
          //icon: Icon(Icons.insert_emoticon, color: Colors.white,),
          //typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
          //borderRadius: 5.0,
          color: Colors.green,
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
      return true;
    } catch (e) {
      AchievementView(
          title: "Error!",
          subTitle: "$e",
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
            print("$e");
            //AchievementState.opening
            //AchievementState.open
            //AchievementState.closing
            //AchievementState.closed
          }).show(context);
      print(e);
      return false;
    }
  }
}
