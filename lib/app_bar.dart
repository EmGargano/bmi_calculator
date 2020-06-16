import 'package:flutter/material.dart';
import 'package:bmicalculator/widget_utils.dart';
import 'package:bmicalculator/input_page_styles.dart';

class BmiAppBar extends StatelessWidget {
  static const String wavingHandEmoji = "\uD83D\uDC4B";
  static const String whiteSkinTone = "\uD83C\uDFFB";

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1.0,
      child: Container(
        height: appBarHeight(context),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(screenAwareSize(25.0, context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              _buildLabel(context),
              _buildIcon(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: DefaultTextStyle.of(context).style.copyWith(fontSize: 34.0),
          children: [
            TextSpan(
                text: 'Hi Manu ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: getEmoji(context)),
          ]),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenAwareSize(11.0, context)),
      child: Container(
        height: screenAwareSize(30.0, context),
        width: screenAwareSize(30.0, context),
        child: Placeholder(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  String getEmoji(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS
        ? wavingHandEmoji
        : wavingHandEmoji + whiteSkinTone;
  }
}
