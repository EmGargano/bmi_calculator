import 'package:flutter/material.dart';
import 'package:bmicalculator/card_title.dart';
import 'package:bmicalculator/height/height_picker.dart';

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




