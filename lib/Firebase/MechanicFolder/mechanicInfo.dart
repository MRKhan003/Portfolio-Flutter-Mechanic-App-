import 'package:cloud_firestore/cloud_firestore.dart';

class mechanicInfo {
  String? mechanicID;
  String? mechanicCity;
  String? mechanciName;
  String? mechanicEmail;
  String? mechanicPassword;
  String? mechanicAddress;
  String? mechanicMobile;
  Timestamp? creationTime;
  mechanicInfo({
    this.mechanicID,
    this.mechanciName,
    this.mechanicEmail,
    this.mechanicAddress,
    this.mechanicCity,
    this.mechanicPassword,
    this.creationTime,
    this.mechanicMobile,
  });
}
