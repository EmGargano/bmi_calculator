import 'package:bmicalculator/height_card.dart';
import 'package:bmicalculator/weight_card.dart';
import 'package:flutter/material.dart';
import 'package:bmicalculator/gender_card.dart';

import 'package:bmicalculator/widget_utils.dart' show screenAwareSize;

class InputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle(context),
            Expanded(child: _buildCards(context)),
            _buildBottom(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24.0,
        top: screenAwareSize(100.0, context),
      ),
      child: Text(
        "BMI Calculator",
        style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        alignment: Alignment.center,
        height: screenAwareSize(108.0, context),
        width: double.infinity,
        child: Switch(value: true, onChanged: (val) {}),
      ),
    );
  }

  Widget _buildCards(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: screenAwareSize(52.0, context),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(child: GenderCard()),
                Expanded(child: WeightCard()),
              ],
            ),
          ),
          Expanded(child: HeightCard()),
        ],
      ),
    );
  }

  Widget _tempCard(String label) {
    return Card(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Text(label),
      ),
    );
  }
}
