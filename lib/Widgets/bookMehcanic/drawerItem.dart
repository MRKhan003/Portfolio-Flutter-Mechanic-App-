import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class drawerItem extends StatelessWidget {
  final String itemName;
  final IconData itemIcon;
  drawerItem({required this.itemName, required this.itemIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 50,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              itemIcon,
              color: Colors.white,
            ),
            Text(
              itemName,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
