import 'package:flutter/material.dart';
import 'package:bmicalculator/widget_utils.dart' show screenAwareSize;
import 'package:bmicalculator/card_title.dart';
import 'package:flutter/rendering.dart';
import 'package:bmicalculator/weight/weight_background.dart';
import 'package:bmicalculator/weight/weight_slider.dart';

class WeightCard extends StatefulWidget {
  final int initialWeight;

  WeightCard({Key key, this.initialWeight}) : super(key: key);

  @override
  WeightCardState createState() => WeightCardState();
}

class WeightCardState extends State<WeightCard> {
  int weight;

  @override
  void initState() {
    weight = widget.initialWeight ?? 70;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: screenAwareSize(16.0, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CardTitle(
              "WEIGHT",
              subtitle: "(KG)",
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _drawSlider(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _drawSlider() {
    return WeightBackground(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.isTight
              ? Container()
              : WeightSlider(
                  minValue: 30,
                  maxValue: 120,
                  value: weight,
                  onChanged: (val) => setState(() => weight = val),
                  width: constraints.maxWidth,
                );
        },
      ),
    );
  }
}


