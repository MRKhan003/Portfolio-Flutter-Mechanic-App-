import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projects/Firebase/MechanicFolder/offerTemplate.dart';
import 'package:projects/Firebase/mechanicController/mechanicController.dart';
import 'package:projects/Firebase/mechanicController/mechanicSigninController.dart';
import 'package:projects/Views/Authentication/mechanicSignin.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class getOffer extends StatefulWidget {
  final String email;
  getOffer({required this.email});
  @override
  State<getOffer> createState() => _getOfferState();
}

class _getOfferState extends State<getOffer> {
  RoundedLoadingButtonController controller = RoundedLoadingButtonController();
  final offer = FirebaseAuth.instance;
  List<String> senderName = [];
  List<String> senderContact = [];
  List<String> senderAddress = [];
  List<String> offerDescription = [];

  mechanicController drawerController = mechanicController();
  mechanicSigninController signinController = mechanicSigninController();

  Future<void> getSenderData() async {
    CollectionReference offer =
        FirebaseFirestore.instance.collection("CustomOffers");
    QuerySnapshot snapshot = await offer.get();

    snapshot.docs.forEach((element) {
      print("Sender ID :${element.id}");
      senderName.add(element['SenderName']);
      senderContact.add(element['SenderContact']);
      senderAddress.add(element['SenderAddress']);
      offerDescription.add(element['SenderDescription']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        elevation: 1,
        title: Text(
          "Check for your offers",
          style: GoogleFonts.poppins(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 19,
            wordSpacing: 1,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                //mainAxisAlignment: MainAxisAlignment.,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back",
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Icon(
                        Icons.emoji_emotions,
                        color: Colors.blue,
                        size: 22,
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.email,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Divider(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: RoundedLoadingButton(
                      controller: controller,
                      onPressed: () {
                        Duration(milliseconds: 3);
                        logout(context);
                      },
                      child: Text(
                        "Logout",
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 800,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: getSenderData(),
                  builder: (context, snapshot) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: int.parse(
                          (senderAddress.length).toString(),
                        ),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              offerTemplate(
                                senderName: senderName[index],
                                contact: senderContact[index],
                                address: senderAddress[index],
                                description: offerDescription[index],
                                cIndex: index,
                                cardList: []
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
                // offerTemplate(
                //   senderName: "Roshaan",
                //   contact: "03064366828",
                //   address: "Lahore",
                //   description: "Bike",
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> logout(BuildContext context) async {
  try {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: mechanicSignin(),
        type: PageTransitionType.fade,
      ),
    );
    return true;
  } catch (e) {
    print("$e");
    return false;
  }
}
