import 'package:flutter/material.dart';
import 'package:bmicalculator/height/height_styles.dart';

class HeightSlider extends StatelessWidget {
  int height;

  HeightSlider({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SliderLabel(height: height),
          Row(
            children: <Widget>[
              SliderCircle(),
              Expanded(child: SliderLine()),
            ],
          ),
        ],
      ),
    );
  }
}

class SliderLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(40, (i) {
        return Expanded(
          child: Container(
            height: 2.0,
            decoration: BoxDecoration(
                color:
                i.isEven ? Theme.of(context).primaryColor : Colors.white),
          ),
        );
      }),
    );
  }
}

class SliderCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: circleSizeAdapted(context),
      width: circleSizeAdapted(context),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.unfold_more,
        color: Colors.white,
        size: circleSizeAdapted(context) * 0.6,
      ),
    );
  }
}

class SliderLabel extends StatelessWidget {
  final int height;

  const SliderLabel({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSizeAdapted(context),
      child: Text(
        "$height",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: labelsFontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}