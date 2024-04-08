import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects/Firebase/userController/customOfferController.dart';
import 'package:projects/Widgets/bookMehcanic/CustomeOffers/customOfferDatabase.dart';
import 'package:projects/Widgets/bookMehcanic/CustomeOffers/offerElements.dart';
import 'package:projects/Widgets/bookMehcanic/buyItemField.dart';

class customOffer extends StatelessWidget {
  offerController controller = offerController();
  offerElements elements = offerElements();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create custom offer",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            wordSpacing: 1,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: buyItemField(
                fieldText: "Name:",
                fieldTextColor: Colors.blue,
                textSize: 16,
                hideInput: false,
                textType: TextInputType.name,
                fieldController: controller.nameController,
                editAble: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: buyItemField(
                fieldText: "Phone Number:",
                fieldTextColor: Colors.blue,
                textSize: 16,
                hideInput: false,
                textType: TextInputType.phone,
                fieldController: controller.contactController,
                editAble: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: buyItemField(
                fieldText: "Address:",
                fieldTextColor: Colors.blue,
                textSize: 16,
                hideInput: false,
                textType: TextInputType.streetAddress,
                fieldController: controller.addressController,
                editAble: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: buyItemField(
                fieldText: "Description:",
                fieldTextColor: Colors.blue,
                textSize: 16,
                hideInput: false,
                textType: TextInputType.name,
                fieldController: controller.descriptionController,
                editAble: true,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                elements.name = controller.nameController.text;
                elements.phoneNumber = controller.contactController.text;
                elements.address = controller.addressController.text;
                elements.description = controller.descriptionController.text;
                elements.creationDate = Timestamp.now();
                customOfferDatabase().sendOffer(elements, context);
              },
              child: Text("Create offer"),
            ),
          ],
        ),
      ),
    );
  }
}
