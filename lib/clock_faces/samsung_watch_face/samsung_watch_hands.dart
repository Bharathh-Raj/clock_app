import 'dart:ui' as ui;

import 'package:clock_app/core/constants/constants.dart';
import 'package:clock_app/core/get_offset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SamsungWatchHands extends CustomPainter {
  final double hourHandLength;
  final double minuteHandLength;
  final double secondHandLength;
  final DateTime dateTime;
  final double clockRadius;

  SamsungWatchHands({
    required this.clockRadius,
    required this.dateTime,
    required this.minuteHandLength,
    required this.hourHandLength,
    required this.secondHandLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    assert(clockRadius >= minuteHandLength, "Minute hand length cannot be greater than Radius");
    assert(clockRadius >= hourHandLength, "Hour hand length cannot be greater than Radius");
    assert(clockRadius * 2 <= size.width, "Canvas size is not enough to accommodate watch with radius of $clockRadius");
    canvas.save();
    canvas.translate(clockRadius, clockRadius);
    _drawHoursHand(canvas);
    _drawMinuteHand(canvas);
    _drawSecondHand(canvas);
    canvas.restore();
  }

  void _drawHoursHand(Canvas canvas) {
    final Paint _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 8
      ..strokeCap = ui.StrokeCap.round
      ..color = Colors.white;

    final double _hourHandTheta = ((dateTime.hour % 12) * Constants.angleBetweenEachHourLine) +
        (Constants.angleBetweenEachHourLine * ((1 / Constants.numberOfMinutes) * dateTime.minute));

    canvas.drawLine(
        Offset(0, 0), GetOffset.getOffsetWithRadiusAndTheta(radius: hourHandLength, theta: _hourHandTheta), _paint);
  }

  void _drawMinuteHand(Canvas canvas) {
    final Paint _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 8
      ..strokeCap = ui.StrokeCap.round
      ..color = Colors.white;

    canvas.drawLine(
        Offset(0, 0),
        GetOffset.getOffsetWithRadiusAndTheta(
            radius: minuteHandLength,
            theta: (dateTime.minute * Constants.angleBetweenEachMinuteLine) +
                (Constants.angleBetweenEachMinuteLine * ((1 / Constants.numberOfSeconds) * dateTime.second))),
        _paint);
  }

  void _drawSecondHand(Canvas canvas) {
    final Paint _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..strokeCap = ui.StrokeCap.round
      ..color = Colors.white;

    canvas.drawLine(
        Offset(0, 0),
        GetOffset.getOffsetWithRadiusAndTheta(
            radius: secondHandLength, theta: dateTime.second * Constants.angleBetweenEachMinuteLine),
        _paint);
  }

  @override
  bool shouldRepaint(covariant SamsungWatchHands oldDelegate) => dateTime.second != oldDelegate.dateTime.second;
}
