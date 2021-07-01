import 'dart:ui' as ui;

import 'package:clock_app/core/constants/constants.dart';
import 'package:clock_app/core/get_offset.dart';
import 'package:flutter/material.dart';

class BaseClock extends CustomPainter {
  final double spaceBeyondMinuteLine;
  final double minuteLineLength;
  final double minuteLineDivBy5Length;
  final double minuteLineDivBy15Length;
  final double clockRadius;
  final bool showClockFrame;
  final double clockFrameStrokeWidth;
  late final double _minuteLineExtremePointRadius;

  BaseClock({
    required this.clockRadius,
    required this.showClockFrame,
    required this.spaceBeyondMinuteLine,
    required this.minuteLineLength,
    required this.minuteLineDivBy5Length,
    required this.minuteLineDivBy15Length,
    required this.clockFrameStrokeWidth,
  }) : _minuteLineExtremePointRadius = clockRadius - spaceBeyondMinuteLine;

  @override
  void paint(Canvas canvas, Size size) {
    assert(size.height == size.width, "Height and width should be equal since the face is round");
    assert(clockRadius * 2 <= size.width, "Canvas size is not enough to accommodate watch with radius of $clockRadius");
    canvas.save();
    canvas.translate(clockRadius, clockRadius);
    _drawBaseCircle(canvas);
    if (showClockFrame) _drawClockFrame(canvas);
    _drawMinutesLine(canvas);
    _drawCenterCircle(canvas);
    canvas.restore();
  }

  void _drawBaseCircle(Canvas canvas) {
    final Paint _paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, -clockRadius),
        Offset(0, clockRadius),
        [Color(0xff7f00ff), Color(0xffE100FF)],
      )
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0, 0), clockRadius, _paint);
  }

  void _drawClockFrame(Canvas canvas) {
    final Paint _paint = Paint()
      ..strokeWidth = clockFrameStrokeWidth
      ..color = Colors.white
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(0, 0), clockRadius + clockFrameStrokeWidth / 2, _paint);
  }

  void _drawMinutesLine(Canvas canvas) {
    final Paint _paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (int minute = 1; minute <= Constants.numberOfMinutes; minute++) {
      final double _theta = Constants.angleBetweenEachMinuteLine * minute;
      final double _radiusOfInnerPoint = _getInnerPointRadiusOfMinuteLine(minute);

      final Offset _extremePoint =
          GetOffset.getOffsetWithRadiusAndTheta(radius: _minuteLineExtremePointRadius, theta: _theta);
      final Offset _innerPoint = GetOffset.getOffsetWithRadiusAndTheta(radius: _radiusOfInnerPoint, theta: _theta);
      canvas.drawLine(_extremePoint, _innerPoint, _paint);
      if (minute % 5 == 0) {
        _drawMinuteText(minute: minute, canvas: canvas, theta: _theta);
      }
    }
  }

  double _getInnerPointRadiusOfMinuteLine(int minute) {
    return _minuteLineExtremePointRadius -
        ((minute % 15 == 0)
            ? minuteLineDivBy15Length
            : (minute % 5 == 0)
                ? minuteLineDivBy5Length
                : minuteLineLength);
  }

  void _drawMinuteText({required Canvas canvas, required int minute, required double theta}) {
    final double fontSize = 12.0;
    TextSpan span =
        new TextSpan(style: new TextStyle(color: Colors.white, fontSize: fontSize), text: minute.toString());
    TextPainter tp = new TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    final Offset _pointToPositionText =
        GetOffset.getOffsetWithRadiusAndTheta(radius: _getInnerPointRadiusOfMinuteLine(minute) - 12, theta: theta);
    tp.paint(canvas, Offset(_pointToPositionText.dx - tp.width / 2, _pointToPositionText.dy - tp.height / 2));
  }

  void _drawCenterCircle(Canvas canvas) {
    final Paint _paint = Paint()
      ..color = Colors.white
      // ..strokeWidth = 6
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0, 0), 8, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
