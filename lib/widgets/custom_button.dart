import 'package:expenz_app/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btName;
  final Color btColor;
  const CustomButton({super.key, required this.btName, required this.btColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: btColor,
      ),
      child: Center(
        child: Text(
          btName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: kWhite,
          ),
        ),
      ),
    );
  }
}
