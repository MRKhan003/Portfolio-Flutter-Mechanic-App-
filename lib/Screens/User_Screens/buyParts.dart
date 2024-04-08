import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects/Widgets/bookMehcanic/buyPartsCard.dart';

class buyParts extends StatelessWidget {
  List<String> imageData = [
    "assets/images/suzukiBrakeShoes.jpg",
    "assets/images/suzukiRingPistons.jpg",
    "assets/images/suzukiShocks.jpg",
  ];
  List<String> hondaImageData = [
    "assets/images/hondaBrakeShoe.jpg",
    "assets/images/hondaRingPistons.jpeg",
    "assets/images/hondaShocks.jpg",
  ];
  List<String> partName = ["Brake shoes", "Ring Pistons", "Shocks"];
  List<int> prices = [2500, 1700, 3000];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 700,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Buy parts for your vehicle",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "assets/images/suzukiLogo.jpg",
                  filterQuality: FilterQuality.high,
                  height: 70,
                  width: 70,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: int.parse(
                    (partName.length).toString(),
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        partsCard(
                          setImage: imageData[index],
                          setName: partName[index],
                          setPrice: prices[index],
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "assets/images/hondaLogo.jpg",
                  filterQuality: FilterQuality.high,
                  height: 70,
                  width: 70,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: int.parse(
                    (partName.length).toString(),
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        partsCard(
                          setImage: hondaImageData[index],
                          setName: partName[index],
                          setPrice: prices[index],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
