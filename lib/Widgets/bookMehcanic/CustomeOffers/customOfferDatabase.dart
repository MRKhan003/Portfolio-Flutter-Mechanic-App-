import 'package:achievement_view/achievement_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projects/Widgets/bookMehcanic/CustomeOffers/offerElements.dart';

class customOfferDatabase {
  Future<bool> sendOffer(offerElements elements, BuildContext context) async {
    FirebaseFirestore ffStore = FirebaseFirestore.instance;

    try {
      await ffStore.collection("CustomOffers").doc(elements.id).set({
        "SenderName": elements.name,
        "SenderContact": elements.phoneNumber,
        "SenderAddress": elements.address,
        "SenderDescription": elements.description,
        "CreationTime": elements.creationDate,
      });
      AchievementView(
          title: "Congrats!",
          subTitle: "Custom offer created",
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
          icon: Icon(
            Icons.emoji_emotions_rounded,
            color: Colors.white,
          ),
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
      return false;
    }
  }
}
