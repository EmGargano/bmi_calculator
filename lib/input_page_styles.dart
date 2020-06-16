import 'package:flutter/material.dart';
import 'package:bmicalculator/widget_utils.dart';

double appBarHeight(BuildContext context) {
  return screenAwareSize(120.0, context) + MediaQuery.of(context).padding.top;
}