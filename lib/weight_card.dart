import 'package:flutter/material.dart';
import 'package:bmicalculator/widget_utils.dart' show screenAwareSize;
import 'package:bmicalculator/card_title.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

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
    return WeightBackgound(
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

class WeightBackgound extends StatelessWidget {
  final Widget child;

  const WeightBackgound({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: screenAwareSize(100.0, context),
          decoration: BoxDecoration(
            color: Color.fromRGBO(244, 244, 244, 1.0),
            borderRadius:
                new BorderRadius.circular(screenAwareSize(50.0, context)),
          ),
          child: child,
        ),
        SvgPicture.asset(
          "images/weight_arrow.svg",
          color: Theme.of(context).primaryColor,
          height: screenAwareSize(12.0, context),
          width: screenAwareSize(18.0, context),
        )
      ],
    );
  }
}

class WeightSlider extends StatelessWidget {
  WeightSlider({
    Key key,
    @required this.minValue,
    @required this.maxValue,
    @required this.width,
    this.onChanged,
    this.value,
  })  : scrollController = new ScrollController(
            initialScrollOffset: (value - minValue) * width / 3),
        super(key: key);

  final int minValue;
  final int maxValue;
  final double width;
  final int value;
  final ValueChanged<int> onChanged;
  final ScrollController scrollController;

  double get itemExtent => width / 3;

  int _indexToValue(int index) => minValue + (index - 1);

  @override
  Widget build(BuildContext context) {
    int itemCount = (maxValue - minValue) + 3;
    return NotificationListener(
      onNotification: _onNotification,
      child: new ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemExtent: itemExtent,
        itemCount: itemCount,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final int value = _indexToValue(index);
          bool isExtra = index == 0 || index == itemCount - 1;

          return isExtra
              ? new Container() // Empty first and last item
              : GestureDetector(
            behavior: HitTestBehavior.translucent,
                onTap: () => _animateTo(value, durationMillis: 250),
                child: FittedBox(
                    child: Text(
                      value.toString(),
                      style: _getTextStyle(value, context: context),
                    ),
                    fit: BoxFit.scaleDown,
                  ),
              );
        },
      ),
    );
  }

  int _offsetToMiddleIndex(double offset) => (offset + width / 2) ~/ itemExtent;

  int _offsetToMiddleValue(double offset) {
    int indexOfMiddleElement = _offsetToMiddleIndex(offset);
    int middleValue = _indexToValue(indexOfMiddleElement);
    middleValue = math.max(minValue, math.min(maxValue, middleValue));
    return middleValue;
  }

  bool _userStoppedScrolling(Notification notification) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        scrollController.position.activity is! HoldScrollActivity;
  }

  _animateTo(int valueToSelect, {int durationMillis = 200}) {
    double targetExtent = (valueToSelect - minValue) * itemExtent;
    scrollController.animateTo(
      targetExtent,
      duration: Duration(milliseconds: durationMillis),
      curve: Curves.decelerate,
    );
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      int middleValue = _offsetToMiddleValue(notification.metrics.pixels);

      if (_userStoppedScrolling(notification)) {
        _animateTo(middleValue);
      }

      if (middleValue != value) {
        onChanged(middleValue); //update selection
      }
    }
    return true;
  }

  TextStyle _getDefaultTextStyle() {
    return TextStyle(
      color: Color.fromRGBO(196, 197, 203, 1.0),
      fontSize: 12.0,
    );
  }

  TextStyle _getHighlightTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 28.0,
    );
  }

  TextStyle _getTextStyle(int itemValue, {BuildContext context}) {
    return itemValue == value
        ? _getHighlightTextStyle(context)
        : _getDefaultTextStyle();
  }
}
