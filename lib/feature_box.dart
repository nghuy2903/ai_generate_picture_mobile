import 'package:ai_generate_picture/pallete.dart';
import 'package:flutter/material.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String headerText;
  final String descriptionText;
  const FeatureBox({
    super.key, 
    required this.color,
    required this.headerText,
    required this.descriptionText
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        )
      ),
      child: Column(
        children: [
          Text(headerText, style: TextStyle(
            fontFamily: 'Cera Pro',
            color: Pallete.blackColor,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
          ),
          Text(descriptionText, style: TextStyle(
            fontFamily: 'Cera Pro',
            color: Pallete.blackColor,
          ),
          )
        ],
      ),
    );
  }
}

