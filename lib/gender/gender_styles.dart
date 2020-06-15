import 'package:flutter/material.dart';
import 'package:bmicalculator/model/gender.dart';
import 'dart:math' as math;
import 'package:bmicalculator/widget_utils.dart' show screenAwareSize;

const double defaultGenderAngle = math.pi / 4;

const Map<Gender, double> genderAngles = {
  Gender.female: -defaultGenderAngle,
  Gender.other: 0.0,
  Gender.male: defaultGenderAngle,
};

double circleSize(BuildContext context) => screenAwareSize(130.0, context);