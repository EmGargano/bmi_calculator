import 'package:flutter/material.dart';
import 'package:bmicalculator/height/height_styles.dart';
import 'package:bmicalculator/height/height_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:bmicalculator/widget_utils.dart' show screenAwareSize;

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
  int startDragHeight;
  double startDragYOffset;

  double get _drawingHeight {
    double totalHeight = widget.widgetHeight;
    double marginBottom = marginBottomAdapted(context);
    double marginTop = marginTopAdapted(context);
    return totalHeight - (marginBottom + marginTop + labelsFontSize);
  }

  double get _pixelsPerUnit {
    return _drawingHeight / widget.totalUnits;
  }

  double get _sliderPosition {
    double halfLabelSize = labelsFontSize / 2;
    int unitsToSlider = widget.height - widget.minHeight;
    return unitsToSlider * _pixelsPerUnit + halfLabelSize;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: _onTapDown,
      onVerticalDragStart: _onDragStart,
      onVerticalDragUpdate: _onDragUpdate,
      child: Stack(
        children: <Widget>[
          _drawPersonImage(),
          _drawSlider(),
          _drawLabels(),
        ],
      ),
    );
  }

  Widget _drawPersonImage() {
    double personImageHeight = _sliderPosition + marginBottomAdapted(context);
    return Align(
        alignment: Alignment.bottomCenter,
        child: SvgPicture.asset(
          "images/person.svg",
          height: personImageHeight,
          width: personImageHeight / 3,
        ));
  }

  Widget _drawSlider() {
    return Positioned(
      child: HeightSlider(height: widget.height),
      bottom: _sliderPosition,
      left: 0.0,
      right: 0.0,
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

  _onTapDown(TapDownDetails tapDownDetails) {
    int height = _globalOffsetToHeight(tapDownDetails.globalPosition);
    widget.onChange(_normalizeHeight(height));
  }

  int _normalizeHeight(int height) {
    return math.max(widget.minHeight, math.min(widget.maxHeight, height));
  }

  int _globalOffsetToHeight(Offset globalOffset) {
    RenderBox renderBox = context.findRenderObject();
    Offset localOffset = renderBox.globalToLocal(globalOffset);
    double dy = localOffset.dy;
    dy = dy - marginTopAdapted(context) - labelsFontSize / 2;
    int height = widget.maxHeight - (dy ~/ _pixelsPerUnit);
    return height;
  }

  _onDragStart(DragStartDetails dragStartDetails) {
    int newHeight = _globalOffsetToHeight(dragStartDetails.globalPosition);

    setState(() {
      startDragYOffset = dragStartDetails.globalPosition.dy;
      startDragHeight = newHeight;
    });
  }

  _onDragUpdate(DragUpdateDetails dragUpdateDetails) {
    double currentYOffset = dragUpdateDetails.globalPosition.dy;
    double verticalDifference = startDragYOffset - currentYOffset;
    int heightDifference = verticalDifference  ~/ _pixelsPerUnit;
    int newHeight = _normalizeHeight(startDragHeight + heightDifference);
    setState(() => widget.onChange(newHeight));
  }
}
