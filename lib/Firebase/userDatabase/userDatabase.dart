import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projects/Firebase/myUser.dart';

class userDatabase {
  myUser currentUser = myUser();
  final FirebaseFirestore ffObject = FirebaseFirestore.instance;

  Future<bool> enterUsertoDatabase(myUser user) async {
    //myUser user = myUser();
    try {
      await ffObject.collection("Users").doc(user.userId).set({
        "User_id": user.userId,
        "User_name": user.userName,
        "User_city": user.userCity,
        "User_email": user.userEmail,
        "User_Password": user.userPassword,
        "Account_created": Timestamp.now(),
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<myUser> getUserByID(String uid) async {
    // ignore: unused_local_variable
    myUser currentUser = myUser();
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await ffObject.collection("Users").doc(currentUser.userId).get();
    return currentUser;
  }
}
