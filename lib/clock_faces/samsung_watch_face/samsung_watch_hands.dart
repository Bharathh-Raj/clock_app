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

  late final double _canvasSide;
  late final double _baseCircleRadius;

  SamsungWatchHands({
    required this.dateTime,
    required this.minuteHandLength,
    required this.hourHandLength,
    required this.secondHandLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _canvasSide = size.height;
    _baseCircleRadius = _canvasSide / 2;
    assert(_baseCircleRadius >= minuteHandLength, "Minute hand length cannot be greater than Radius");
    assert(_baseCircleRadius >= hourHandLength, "Hour hand length cannot be greater than Radius");
    canvas.save();
    canvas.translate(_baseCircleRadius, _baseCircleRadius);
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
    canvas.drawLine(
        Offset(0, 0),
        GetOffset.getOffsetWithRadiusAndTheta(
            radius: hourHandLength, theta: (dateTime.hour % 12) * 5 * Constants.angleBetweenEachMinuteLine),
        _paint);
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
            radius: minuteHandLength, theta: dateTime.minute * Constants.angleBetweenEachMinuteLine),
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
