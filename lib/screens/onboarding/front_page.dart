import 'package:expenz_app/constants/colors.dart';
import 'package:flutter/material.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/logo.png",
          width: 131,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            "Expenz",
            style: TextStyle(
                fontSize: 56, color: kMainColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
