import 'package:flutter/material.dart';
import 'package:bmicalculator/widget_utils.dart' show screenAwareSize;
import 'package:flutter_svg/flutter_svg.dart';

class WeightBackground extends StatelessWidget {
  final Widget child;

  const WeightBackground({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: screenAwareSize(100.0, context),
          decoration: BoxDecoration(
            color: Color.fromRGBO(244, 244, 244, 1.0),
            borderRadius:
            new BorderRadius.circular(screenAwareSize(50.0, context)),
          ),
          child: child,
        ),
        SvgPicture.asset(
          "images/weight_arrow.svg",
          color: Theme.of(context).primaryColor,
          height: screenAwareSize(12.0, context),
          width: screenAwareSize(18.0, context),
        )
      ],
    );
  }
}