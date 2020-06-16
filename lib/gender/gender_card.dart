import 'package:bmicalculator/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:bmicalculator/model/gender.dart';
import 'package:bmicalculator/gender/gender_styles.dart';
import 'package:bmicalculator/card_title.dart';
import 'package:bmicalculator/gender/gender_icon.dart';
import 'package:bmicalculator/gender/gender_arrow.dart';
import 'package:bmicalculator/gender/gender_circle.dart';

class GenderCard extends StatefulWidget {
  final Gender initialGender;

  const GenderCard({Key key, this.initialGender}) : super(key: key);

  @override
  _GenderCardState createState() => _GenderCardState();
}



class _GenderCardState extends State<GenderCard>
    with SingleTickerProviderStateMixin {
  Gender selectedGender;
  AnimationController _arrowAnimationController;

  @override
  void initState() {
    selectedGender = widget.initialGender ?? Gender.other;
    _arrowAnimationController = new AnimationController(
        vsync: this,
        lowerBound: -defaultGenderAngle,
        upperBound: defaultGenderAngle,
        value: genderAngles[selectedGender]);
    super.initState();
  }

  @override
  void dispose() {
    _arrowAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: screenAwareSize(16.0, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CardTitle("GENDER"),
            Padding(
                padding: EdgeInsets.only(top: screenAwareSize(32.0, context)),
                child: _drawMainStack()),
          ],
        ),
      ),
    );
  }

  Widget _drawMainStack() {
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _drawCircularIndicator(),
          GenderIconTranslated(gender: Gender.female, selectedGender: selectedGender,),
          GenderIconTranslated(gender: Gender.other, selectedGender: selectedGender,),
          GenderIconTranslated(gender: Gender.male, selectedGender: selectedGender,),
          _drawGestureDetector(),
        ],
      ),
    );
  }

  Widget _drawCircularIndicator() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        GenderCircle(),
        GenderArrow(
          listenable: _arrowAnimationController,
        )
      ],
    );
  }

  Widget _drawGestureDetector() {
    return Positioned.fill(
      child: TopHandler(
        onGenderTapped: _setSelectedGender,
      ),
    );
  }

  void _setSelectedGender(Gender gender) {
    setState(() => selectedGender = gender);
    _arrowAnimationController.animateTo(
      genderAngles[gender],
      duration: Duration(milliseconds: 250),
      curve: Curves.linearToEaseOut,
    );
  }

}

class TopHandler extends StatelessWidget {
  final Function(Gender) onGenderTapped;

  const TopHandler({Key key, this.onGenderTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () => onGenderTapped(Gender.female),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => onGenderTapped(Gender.other),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => onGenderTapped(Gender.male),
          ),
        ),
      ],
    );
  }
}
