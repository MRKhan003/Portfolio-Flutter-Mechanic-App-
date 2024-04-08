import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projects/Firebase/MechanicFolder/mechanicInfo.dart';

class mechanicDatabase {
  mechanicInfo currentMechanic = mechanicInfo();
  FirebaseFirestore ffObject = FirebaseFirestore.instance;
  Future<bool> sendUsertoDatabase(mechanicInfo mechanic) async {
    try {
      await ffObject.collection("Mechanic").doc(mechanic.mechanicID).set({
        "mechanicID": mechanic.mechanicID,
        "mechanicName": mechanic.mechanciName,
        "mechanicEmail": mechanic.mechanicEmail,
        "mechanicNumber": mechanic.mechanicMobile,
        "mechanicAddress": mechanic.mechanicAddress,
        "mechanicPassword": mechanic.mechanicPassword,
        "accountCreated": Timestamp.now(),
      });
      print("Data sent to Database");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<mechanicInfo> getUserByID(String uid) async {
    // ignore: unused_local_variable
    mechanicInfo currentMechanic = mechanicInfo();
    FirebaseFirestore ffObject = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await ffObject
        .collection("Mechanic")
        .doc(currentMechanic.mechanicID)
        .get();
    return currentMechanic;
  }
}
