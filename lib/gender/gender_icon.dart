import 'package:flutter/material.dart';
import 'gender_styles.dart';
import 'package:bmicalculator/model/gender.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:bmicalculator/widget_utils.dart' show screenAwareSize;

class GenderIconTranslated extends StatelessWidget {
  final Gender gender;

  static final Map<Gender, String> _genderImages = {
    Gender.female: "images/gender_female.svg",
    Gender.other: "images/gender_other.svg",
    Gender.male: "images/gender_male.svg",
  };

  const GenderIconTranslated({Key key, this.gender}) : super(key: key);

  bool _isOtherGender() => gender == Gender.other;

  String _assetName() => _genderImages[gender];

  double _iconSize(BuildContext context) {
    return screenAwareSize(_isOtherGender() ? 32.0 : 26.0, context);
  }

  double _genderLeftPadding(BuildContext context) {
    return screenAwareSize(_isOtherGender() ? 4.0 : 0.0, context);
  }

  @override
  Widget build(BuildContext context) {
    Widget icon = Padding(
      padding: EdgeInsets.only(left: _genderLeftPadding(context)),
      child: SvgPicture.asset(
        _assetName(),
        width: _iconSize(context),
        height: _iconSize(context),
      ),
    );

    Widget rotatedIcon = Transform.rotate(
      angle: -genderAngles[gender],
      child: icon,
    );

    Widget iconWithALine = Padding(
      padding: EdgeInsets.only(bottom: circleSize(context) / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          rotatedIcon,
          GenderLine(),
        ],
      ),
    );

    Widget rotatedIconWithALine = Transform.rotate(
      alignment: Alignment.bottomCenter,
      angle: genderAngles[gender],
      child: iconWithALine,
    );

    Widget centeredIconWithALine = Padding(
      padding: EdgeInsets.only(bottom: circleSize(context) / 2),
      child: rotatedIconWithALine,
    );

    return centeredIconWithALine;
  }
}

class GenderLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: screenAwareSize(8.0, context),
        top: screenAwareSize(10.0, context),
      ),
      child: Container(
        height: screenAwareSize(10.0, context),
        width: 1.0,
        color: Color.fromRGBO(110, 110, 110, 0.1),
      ),
    );
  }
}