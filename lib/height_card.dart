import 'package:flutter/material.dart';
import 'package:bmicalculator/card_title.dart';
import 'dart:math' as math;
import 'package:bmicalculator/height_styles.dart';

import 'package:bmicalculator/widget_utils.dart' show screenAwareSize;

class HeightCard extends StatefulWidget {
  final int initialHeight;

  HeightCard({Key key, this.initialHeight}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HeightCardState();
}

class HeightCardState extends State<HeightCard> {
  int height;

  @override
  void initState() {
    height = widget.initialHeight ?? 170;
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
              "HEIGHT",
              subtitle: "(cm)",
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return HeightPicker(
                      widgetHeight: constraints.maxHeight,
                      height: height,
                      onChange: (val) => setState(() => height = val),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HeightPicker extends StatefulWidget {
  final int maxHeight;
  final int minHeight;
  final double widgetHeight;
  final int height;
  final ValueChanged<int> onChange;

  const HeightPicker({
    Key key,
    @required this.widgetHeight,
    @required this.height,
    this.maxHeight = 190,
    this.minHeight = 145,
    this.onChange,
  }) : super(key: key);

  int get totalUnits => maxHeight - minHeight;

  @override
  State<StatefulWidget> createState() => HeightPickerState();
}

class HeightPickerState extends State<HeightPicker> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _drawLabels(),
      ],
    );
  }

  Widget _drawLabels() {
    int labelsToDisplay = widget.totalUnits ~/ 5 + 1;
    List<Widget> labels = List.generate(labelsToDisplay, (index) {
      return Text(
        "${widget.maxHeight - 5 * index}",
        style: labelsTextStyle,
      );
    });

    return Align(
      alignment: Alignment.centerRight,
      child: IgnorePointer(
        child: Padding(
          padding: EdgeInsets.only(
            right: screenAwareSize(12.0, context),
            bottom: marginBottomAdapted(context),
            top: marginTopAdapted(context),
          ),
          child: Column(
            children: labels,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
      ),
    );
  }
}
