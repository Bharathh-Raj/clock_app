import 'dart:math' as math;
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';

class SamsungWatchFace extends CustomPainter {
  static const int _numberOfMintues = 60;
  static const double _angleBetweenMinutePointers = (2 * math.pi) / _numberOfMintues;

  final double spaceBeyondMinuteLine;
  final double minuteLineLength;
  final double minuteLineDivBy5Length;
  final double minuteLineDivBy15Length;
  late final double _baseCircleRadius;
  late final double _canvasSide;
  late final double _minuteLineExtremePointRadius;
  SamsungWatchFace({
    this.spaceBeyondMinuteLine = 4,
    this.minuteLineLength = 4,
    this.minuteLineDivBy5Length = 7,
    this.minuteLineDivBy15Length = 10,
  });

  @override
  void paint(Canvas canvas, Size size) {
    assert(size.height == size.width, "Height and width should be equal since the face is round");
    _canvasSide = size.height;
    _baseCircleRadius = _canvasSide / 2;
    _minuteLineExtremePointRadius = _baseCircleRadius - spaceBeyondMinuteLine;
    canvas.save();
    canvas.translate(_baseCircleRadius, _baseCircleRadius);
    _drawBaseCircle(canvas);
    _drawMinutesLine(canvas);
    _drawCenterCircle(canvas);
    // _drawHoursHand(canvas, _side);
    _drawMinuteHand(canvas);
    canvas.restore();
  }

  void _drawBaseCircle(Canvas canvas) {
    final Paint _paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, -_baseCircleRadius),
        Offset(0, _baseCircleRadius),
        [Color(0xff7f00ff), Color(0xffE100FF)],
      )
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0, 0), _baseCircleRadius, _paint);
  }

  void _drawMinutesLine(Canvas canvas) {
    final Paint _paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (int minute = 1; minute <= _numberOfMintues; minute++) {
      final double _theta = _angleBetweenMinutePointers * minute;
      final double _radiusOfInnerPoint = _getInnerPointRadiusOfMinuteLine(minute);

      final Offset _extremePoint = _getOffsetWithRadiusAndTheta(radius: _minuteLineExtremePointRadius, theta: _theta);
      final Offset _innerPoint = _getOffsetWithRadiusAndTheta(radius: _radiusOfInnerPoint, theta: _theta);
      canvas.drawLine(_extremePoint, _innerPoint, _paint);
      if (minute % 5 == 0) {
        _drawMinuteText(minute: minute, canvas: canvas, theta: _theta);
      }
    }
  }

  Offset _getOffsetWithRadiusAndTheta({required double radius, required double theta}) {
    theta = theta - (math.pi / 2);
    return Offset(radius * math.cos(theta), radius * math.sin(theta));
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
        _getOffsetWithRadiusAndTheta(radius: _getInnerPointRadiusOfMinuteLine(minute) - 12, theta: theta);
    tp.paint(canvas, Offset(_pointToPositionText.dx - tp.width / 2, _pointToPositionText.dy - tp.height / 2));
  }

  void _drawMinuteHand(Canvas canvas) {
    final Paint _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 8
      ..strokeCap = ui.StrokeCap.round
      ..color = Colors.white;

    final double _minuteHandLength = 100;
    canvas.drawLine(Offset(0, 0),
        _getOffsetWithRadiusAndTheta(radius: _minuteHandLength, theta: 30 * _angleBetweenMinutePointers), _paint);
  }

  void _drawCenterCircle(Canvas canvas) {
    final Paint _paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(0, 0), 8, _paint);
  }

  void _drawHoursHand(Canvas canvas, double side) {
    final Paint _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 8
      ..strokeCap = ui.StrokeCap.round
      ..color = Colors.white;
    canvas.drawLine(Offset(50, 50), Offset(side / 2, side / 2), _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
