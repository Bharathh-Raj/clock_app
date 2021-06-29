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
    _drawBaseCircle(canvas);
    _drawMinutesLine(canvas);
    _drawCenterCircle(canvas);
    // _drawHoursHand(canvas, _side);
    _drawMinutesPointer(canvas);
  }

  void _drawBaseCircle(Canvas canvas) {
    final Paint _paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(_canvasSide / 2, _canvasSide),
        Offset(_canvasSide / 2, 0),
        [Colors.cyan[500]!, Colors.cyan[700]!],
      )
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(_canvasSide / 2, _canvasSide / 2), 100, _paint);
  }

  void _drawMinutesLine(Canvas canvas) {
    canvas.save();
    canvas.translate(_baseCircleRadius, _baseCircleRadius);
    final Paint _paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (int minute = 0; minute <= _numberOfMintues; minute++) {
      final double _theta = _angleBetweenMinutePointers * minute;
      final double _radiusOfInnerPoint = _getInnerPointRadiusOfMinuteLine(minute);

      final Offset _extremePoint = _getPointWithRadiusAndTheta(radius: _minuteLineExtremePointRadius, theta: _theta);
      final Offset _innerPoint = _getPointWithRadiusAndTheta(radius: _radiusOfInnerPoint, theta: _theta);
      canvas.drawLine(_extremePoint, _innerPoint, _paint);
      if (minute % 5 == 0) {
        _drawMinuteText(minute: minute, canvas: canvas, theta: _theta);
      }
    }
    canvas.restore();
  }

  Offset _getPointWithRadiusAndTheta({required double radius, required double theta}) {
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
    TextSpan span = new TextSpan(
        style: new TextStyle(color: Colors.white, fontSize: fontSize), text: ((minute + 15) % 60).toString());
    TextPainter tp = new TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    final Offset _pointToPositionText =
        _getPointWithRadiusAndTheta(radius: _getInnerPointRadiusOfMinuteLine(minute) - 12, theta: theta);
    tp.paint(canvas, Offset(_pointToPositionText.dx - tp.width / 2, _pointToPositionText.dy - tp.height / 2));
  }

  void _drawMinutesPointer(Canvas canvas) {
    final Paint _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..strokeCap = ui.StrokeCap.round
      ..color = Colors.white;

    // final double _minutePointerLength = 10;
    //
    // canvas.drawLine(Offset(_canvasSide / 2, _canvasSide / 2),
    //     _getPointWithRadiusAndTheta(radius: _minutePointerLength, theta: 50), _paint);
  }

  void _drawCenterCircle(Canvas canvas) {
    final Paint _paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(_canvasSide / 2, _canvasSide / 2), 8, _paint);
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
