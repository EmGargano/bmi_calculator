import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';

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