import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bmicalculator/gender/gender_styles.dart';

import 'package:bmicalculator/widget_utils.dart' show screenAwareSize;

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
          angle: - defaultGenderAngle,
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