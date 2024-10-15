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
          color: Colors.green,
          duration: Duration(seconds: 5),
          listener: (status) {
            print(status);
          }).show(context);
      return true;
    } catch (e) {
      AchievementView(
          title: "Error!",
          subTitle: "$e",
          icon: Icon(
            Icons.emoji_emotions_rounded,
            color: Colors.white,
          ),
          color: Colors.red,
          duration: Duration(seconds: 5),
          listener: (status) {
            print("$e");
          }).show(context);
      return false;
    }
  }
}
