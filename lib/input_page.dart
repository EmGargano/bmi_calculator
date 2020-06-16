import 'package:flutter/material.dart';
import 'package:bmicalculator/height/height_card.dart';
import 'package:bmicalculator/weight/weight_card.dart';
import 'package:bmicalculator/gender/gender_card.dart';
import 'package:bmicalculator/input_page_styles.dart';
import 'package:bmicalculator/app_bar.dart';

import 'package:bmicalculator/widget_utils.dart' show screenAwareSize;

class InputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: BmiAppBar(),
        preferredSize: Size.fromHeight(appBarHeight(context)),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
}
