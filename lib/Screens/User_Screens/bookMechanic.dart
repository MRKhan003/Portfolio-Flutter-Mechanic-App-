import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:projects/Widgets/bookMehcanic/mechanicCard.dart";

class bookMechanic extends StatefulWidget {
  @override
  State<bookMechanic> createState() => _bookMechanicState();
}

class _bookMechanicState extends State<bookMechanic> {
  final mechanic = FirebaseAuth.instance;

  List<String> electricianName = [
    "Electrician1",
    "Electrician2",
    "Electrician3",
    "Electrician4",
    "Electrician5",
    "Electrician6",
  ];

  List<String> mechanicName = [];

  // Future getMechanicName() async {
  //   await FirebaseFirestore.instance.collection("Mechanic").get().then(
  //         (snapshot) => snapshot.docs.forEach(
  //           (document) {
  //             print(document.reference);
  //             mechanicName.add(document.reference.id);
  //           },
  //         ),
  //       );
  // }

  Future<void> getMechanicName() async {
    // Reference to the "users" collection
    CollectionReference mechanic =
        FirebaseFirestore.instance.collection('Mechanic');

    // Get documents from the "users" collection
    QuerySnapshot querySnapshot = await mechanic.get();

    // Loop through the documents and print data
    querySnapshot.docs.forEach((doc) {
      print('User ID: ${doc.id}, Name: ${doc['mechanicName']}');
      mechanicName.add(doc['mechanicName']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 600,
          //width: 500,
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Book a mechanic of your choice",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Electricians:",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: int.parse(
                      (electricianName.length).toString(),
                    ),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          mechanicCard(
                            profilePic: "assets/images/logo.png",
                            mechanicName: electricianName[index],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Mechanics:",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future: getMechanicName(),
                  builder: (context, snapshot) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: int.parse(
                          (mechanicName.length).toString(),
                        ),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              mechanicCard(
                                profilePic: "assets/images/logo.png",
                                mechanicName: mechanicName[index],
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
