import 'package:flutter/material.dart';
import 'package:bmicalculator/gender/gender_styles.dart';

class GenderCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize(context),
      height: circleSize(context),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(244, 244, 244, 1.0),
      ),
    );
  }
}