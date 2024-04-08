import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
//import 'packge_transition/page_transition.dart';
import 'package:projects/Firebase/UserItems/itemsController.dart';
import 'package:projects/Firebase/UserItems/itemsElements.dart';
import 'package:projects/Widgets/bookMehcanic/buyItem.dart';

class partsCard extends StatefulWidget {
  final String setImage;
  final String setName;
  // ignore: prefer_typing_uninitialized_variables setPrice;
  int setPrice;

  partsCard({
    required this.setImage,
    required this.setName,
    required this.setPrice,
  });

  itemsController controller = itemsController();
  itemsElements elements = itemsElements();

  @override
  State<partsCard> createState() => _partsCardState();
}

class _partsCardState extends State<partsCard> {
  int increment = 1;
  int newPrice = 0;

  int initState() {
    newPrice = widget.setPrice;
    widget.elements.itemName = widget.setName;
    return 0;
  }

  void incrementPrice() {
    setState(() {
      increment++;
      if (increment > 1) {
        widget.setPrice += newPrice;
      } else {
        widget.setPrice = newPrice;
      }
    });
  }

  void decrementPrice() {
    setState(() {
      if (increment >= 1) {
        increment--;
        widget.setPrice -= newPrice;
      } else {
        increment = 0;
        widget.setPrice = newPrice;
      }
    });
  }

  int get itemPrice => widget.setPrice;
  String get itemName => widget.setName;
  int get itemCount => increment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 250,
      width: 150,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              widget.setImage,
              filterQuality: FilterQuality.high,
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.setName),
                Text(
                  widget.setPrice.toString(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select Items",
                ),
                GestureDetector(
                  onTap: () {
                    decrementPrice();
                  },
                  child: Text(
                    "-",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                  ),
                ),
                Text("$increment"),
                GestureDetector(
                  onTap: () {
                    incrementPrice();
                  },
                  child: Text(
                    "+",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                initState();
                Navigator.push(
                    context,
                    PageTransition(
                      child: buyItem(
                        itemPrice,
                        itemName,
                        itemCount,
                      ),
                      type: PageTransitionType.fade,
                    ));
              },
              child: Text("Buy Item"),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
    // ignore: dead_code
  }
}
