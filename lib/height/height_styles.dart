import 'package:flutter/material.dart';
import 'package:bmicalculator/widget_utils.dart' show screenAwareSize;

double marginBottomAdapted(BuildContext context) => screenAwareSize(marginBottom, context);

double marginTopAdapted(BuildContext context) => screenAwareSize(marginBottom, context);

double circleSizeAdapted(BuildContext context) => screenAwareSize(circleSize, context);

const TextStyle labelsTextStyle = TextStyle(
  fontSize: labelsFontSize,
  color: labelsGrey,
);

const marginBottom = circleSize / 2;
const marginTop = 26.0;
const circleSize = 45.0;
const labelsFontSize = 13.0;
const labelsGrey = const Color.fromRGBO(216, 217, 223, 1.0);