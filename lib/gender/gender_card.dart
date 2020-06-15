import 'package:bmicalculator/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:bmicalculator/model/gender.dart';
import 'gender_styles.dart';
import 'package:bmicalculator/card_title.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'gender_icon.dart';

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
          GenderIconTranslated(gender: Gender.female),
          GenderIconTranslated(gender: Gender.other),
          GenderIconTranslated(gender: Gender.male),
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

class GenderArrow extends AnimatedWidget {

  const GenderArrow({Key key, Listenable listenable}) : super(key: key, listenable: listenable);

  double _arrowLength(BuildContext context) => screenAwareSize(45.0, context);

  double _translationOffset(BuildContext context) =>
      _arrowLength(context) * -0.45;

  @override
  Widget build(BuildContext context) {
    Animation animation = listenable;
    return Transform.rotate(
      angle: animation.value,
      child: Transform.translate(
        offset: Offset(0.0, _translationOffset(context)),
        child: Transform.rotate(
          angle: -defaultGenderAngle,
          child: SvgPicture.asset(
            "images/gender_arrow.svg",
            color: Theme.of(context).primaryColor,
            width: _arrowLength(context),
            height: _arrowLength(context),
          ),
        ),
      ),
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
