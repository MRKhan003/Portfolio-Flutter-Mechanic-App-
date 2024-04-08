import 'dart:async';

import 'package:achievement_view/achievement_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projects/Firebase/UserItems/itemsController.dart';
import 'package:projects/Firebase/UserItems/itemsElements.dart';
import 'package:projects/Firebase/UserItems/userItemsDatabase.dart';
import 'package:projects/Screens/User_Screens/homeScreen.dart';
import 'package:projects/Widgets/bookMehcanic/buyItemField.dart';

// ignore: must_be_immutable
class buyItem extends StatelessWidget {
  int itemPrice;
  String itemName;
  int itemCount;

  buyItem(this.itemPrice, this.itemName, this.itemCount);
  itemsElements elements = itemsElements();
  itemsController controller = itemsController();

  @override
  Widget build(BuildContext context) {
    //initState();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Enter information to confirm your order",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 1,
        actions: [
          Image.asset(
            "assets/images/logo.png",
            filterQuality: FilterQuality.high,
            height: 50,
            width: 50,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: buyItemField(
                fieldController: controller.userNameController,
                fieldText: "Your Name",
                fieldTextColor: Colors.blue,
                textSize: 16,
                hideInput: false,
                textType: TextInputType.name,
                editAble: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: buyItemField(
                fieldController: controller.contactController,
                fieldText: "Your Phone Number",
                fieldTextColor: Colors.blue,
                textSize: 16,
                hideInput: false,
                textType: TextInputType.phone,
                editAble: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: buyItemField(
                fieldController: controller.userEmailController,
                fieldText: "Your Email",
                fieldTextColor: Colors.blue,
                textSize: 16,
                hideInput: false,
                textType: TextInputType.emailAddress,
                editAble: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: buyItemField(
                fieldText: "Your Address",
                fieldController: controller.userAddressController,
                fieldTextColor: Colors.blue,
                textSize: 16,
                hideInput: false,
                textType: TextInputType.streetAddress,
                editAble: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Item Name:",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: buyItemField(
                fieldController: controller.itemNameController,
                fieldText: itemName.toString(),
                fieldTextColor: Colors.blue,
                textSize: 16,
                hideInput: false,
                textType: TextInputType.streetAddress,
                editAble: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "No of parts:",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: buyItemField(
                fieldController: controller.itemCountController,
                fieldText: itemCount.toString(),
                fieldTextColor: Colors.blue,
                textSize: 16,
                hideInput: false,
                textType: TextInputType.streetAddress,
                editAble: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Price:",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: buyItemField(
                fieldController: controller.priceController,
                fieldText: itemPrice.toString(),
                fieldTextColor: Colors.blue,
                textSize: 16,
                hideInput: false,
                textType: TextInputType.streetAddress,
                editAble: false,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.userNameController.text.isNotEmpty &&
                    controller.userEmailController.text.isNotEmpty &&
                    controller.userAddressController.text.isNotEmpty) {
                  elements.itemName = itemName;
                  elements.userEmail = controller.userEmailController.text;
                  elements.userName = controller.userNameController.text;
                  elements.userAddress = controller.userAddressController.text;
                  elements.userContact = controller.contactController.text;
                  elements.itemCount = itemCount.toString();
                  elements.itemPrice = itemPrice.toString();

                  userItemsDatabase().sendDataToDatabase(elements, context);
                  Timer(
                    Duration(seconds: 5),
                    () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: homeScreen(), type: PageTransitionType.fade),
                      );
                    },
                  );
                } else {
                  AchievementView(
                      title: "Error!",
                      subTitle: "Fill complete information",
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
                        print(status);
                        //AchievementState.opening
                        //AchievementState.open
                        //AchievementState.closing
                        //AchievementState.closed
                      }).show(context);
                }
              },
              child: Text("Confirm Order"),
            ),
          ],
        ),
      ),
    );
  }
}
