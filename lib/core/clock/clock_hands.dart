import 'dart:ui' as ui;

import 'package:clock_app/core/constants/constants.dart';
import 'package:clock_app/core/get_offset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClockHands extends CustomPainter {
  final double hourHandLength;
  final double minuteHandLength;
  final double secondHandLength;
  final double hourHandStrokeWidth;
  final double minuteHandStrokeWidth;
  final double secondHandStrokeWidth;
  final double centerCircleRadius;
  final Color centerCircleColor;
  final Color secondaryCircleColor;
  final double secondaryCircleRadius;
  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;
  final DateTime dateTime;
  final double clockRadius;

  final bool showSecondHand;
  final bool showMinuteHand;
  final bool showHourHand;

  ClockHands({
    required this.hourHandStrokeWidth,
    required this.minuteHandStrokeWidth,
    required this.secondHandStrokeWidth,
    required this.centerCircleRadius,
    required this.centerCircleColor,
    required this.secondaryCircleColor,
    required this.secondaryCircleRadius,
    required this.minuteHandColor,
    required this.secondHandColor,
    required this.hourHandColor,
    required this.clockRadius,
    required this.dateTime,
    required this.minuteHandLength,
    required this.hourHandLength,
    required this.secondHandLength,
    required this.showSecondHand,
    required this.showMinuteHand,
    required this.showHourHand,
  });

  @override
  void paint(Canvas canvas, Size size) {
    assert(clockRadius >= minuteHandLength, "Minute hand length cannot be greater than Radius");
    assert(clockRadius >= hourHandLength, "Hour hand length cannot be greater than Radius");
    assert(clockRadius * 2 <= size.width, "Canvas size is not enough to accommodate watch with radius of $clockRadius");
    canvas.save();
    canvas.translate(clockRadius, clockRadius);
    if (showHourHand) _drawHoursHand(canvas);
    if (showMinuteHand) _drawMinuteHand(canvas);
    _drawSecondaryCenterCircle(canvas);
    if (showSecondHand) _drawSecondHand(canvas);
    _drawCenterCircle(canvas);
    canvas.restore();
  }

  void _drawHoursHand(Canvas canvas) {
    final Paint _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = hourHandStrokeWidth
      ..strokeCap = ui.StrokeCap.round
      ..color = hourHandColor;

    final double _hourHandTheta = ((dateTime.hour % 12) * Constants.angleBetweenEachHourLine) +
        (Constants.angleBetweenEachHourLine * ((1 / Constants.numberOfMinutes) * dateTime.minute));

    canvas.drawLine(
        Offset(0, 0), GetOffset.getOffsetWithRadiusAndTheta(radius: hourHandLength, theta: _hourHandTheta), _paint);
  }

  void _drawMinuteHand(Canvas canvas) {
    final Paint _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = minuteHandStrokeWidth
      ..strokeCap = ui.StrokeCap.round
      ..color = minuteHandColor;

    final double _minuteHandTheta = (dateTime.minute * Constants.angleBetweenEachMinuteLine) +
        (Constants.angleBetweenEachMinuteLine * ((1 / Constants.numberOfSeconds) * dateTime.second));

    canvas.drawLine(
        Offset(0, 0), GetOffset.getOffsetWithRadiusAndTheta(radius: minuteHandLength, theta: _minuteHandTheta), _paint);
  }

  void _drawSecondHand(Canvas canvas) {
    final Paint _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = secondHandStrokeWidth
      ..strokeCap = ui.StrokeCap.round
      ..color = secondHandColor;

    canvas.drawLine(
        Offset(0, 0),
        GetOffset.getOffsetWithRadiusAndTheta(
            radius: secondHandLength, theta: dateTime.second * Constants.angleBetweenEachMinuteLine),
        _paint);
  }

  void _drawCenterCircle(Canvas canvas) {
    final Paint _paint = Paint()
      ..color = centerCircleColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0, 0), centerCircleRadius, _paint);
  }

  void _drawSecondaryCenterCircle(Canvas canvas) {
    final Paint _paint = Paint()
      ..color = secondaryCircleColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0, 0), secondaryCircleRadius, _paint);
  }

  @override
  bool shouldRepaint(covariant ClockHands oldDelegate) => dateTime.second != oldDelegate.dateTime.second;
}
