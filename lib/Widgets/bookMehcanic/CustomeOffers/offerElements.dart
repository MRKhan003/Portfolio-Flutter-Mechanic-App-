import 'package:cloud_firestore/cloud_firestore.dart';

class offerElements {
  String? id;
  String? name;
  String? phoneNumber;
  String? address;
  String? description;
  Timestamp? creationDate;
  offerElements(
      {this.id,
      this.name,
      this.phoneNumber,
      this.address,
      this.description,
      this.creationDate});
}
