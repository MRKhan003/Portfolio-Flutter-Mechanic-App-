import 'package:flutter/material.dart';

class mechanicCard extends StatelessWidget {
  final String profilePic;
  final String mechanicName;

  mechanicCard({
    required this.profilePic,
    required this.mechanicName,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          child: Column(
            children: [
              Image.asset(
                profilePic,
                filterQuality: FilterQuality.high,
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: 5,
              ),
              Text(mechanicName),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Chat"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
