import 'dart:math' as math;
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';

class SamsungWatchFace extends CustomPainter {
  static const int _numberOfMintuesPointer = 60;
  static const double _angleBetweenMinutePointers = (2 * math.pi) / _numberOfMintuesPointer;

  final double spaceBeyondMinuteLine;
  late final double _baseCircleRadius;
  late final double _canvasSide;
  late final double _minuteLineExtremePointRadius;
  SamsungWatchFace({
    this.spaceBeyondMinuteLine = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    assert(size.height == size.width, "Height and width should be equal since the face is round");
    _canvasSide = size.height;
    _baseCircleRadius = _canvasSide / 2;
    _minuteLineExtremePointRadius = _baseCircleRadius - spaceBeyondMinuteLine;
    _drawBaseCircle(canvas);
    _drawMinutesPointer(canvas);
    _drawCenterCircle(canvas);
    // _drawHoursHand(canvas, _side);
    // _drawMinutesPointer(canvas, _side);
  }

  void _drawBaseCircle(Canvas canvas) {
    final Paint _paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(_canvasSide / 2, _canvasSide),
        Offset(_canvasSide / 2, 0),
        [Colors.cyan[400]!, Colors.cyan[100]!],
      )
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(_canvasSide / 2, _canvasSide / 2), 100, _paint);
  }

  void _drawMinutesPointer(Canvas canvas) {
    canvas.save();
    canvas.translate(_baseCircleRadius, _baseCircleRadius);
    // canvas.scale(1, -1);
    final Paint _paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (int i = 0; i <= _numberOfMintuesPointer; i++) {
      final Offset _offsetOne =
          _getExtremePointOfTheMinuteLine(minute: i, minuteLineRadius: _minuteLineExtremePointRadius);
      final Offset _offsetTwo =
          _getInnerPointOfTheMinuteLine(minute: i, minuteLineRadius: _minuteLineExtremePointRadius);
      canvas.drawLine(_offsetOne, _offsetTwo, _paint);
      // canvas.drawPoints(PointMode.points, [_offsetTwo], _paint);
      if (i % 5 == 0) {}
    }
    canvas.restore();
  }

  Offset _getExtremePointOfTheMinuteLine({required double minuteLineRadius, required int minute}) {
    final double _theta = _angleBetweenMinutePointers * minute;
    return Offset(minuteLineRadius * math.cos(_theta), minuteLineRadius * math.sin(_theta));
  }

  Offset _getInnerPointOfTheMinuteLine({required double minuteLineRadius, required int minute}) {
    final double _minuteLineLength = 4;
    final double _minuteLineDivBy5Len = 7;
    final double _minuteLineDivBy15Len = 10;
    final double _theta = _angleBetweenMinutePointers * minute;
    return Offset(
        (minuteLineRadius -
                ((minute % 15 == 0)
                    ? _minuteLineDivBy15Len
                    : (minute % 5 == 0)
                        ? _minuteLineDivBy5Len
                        : _minuteLineLength)) *
            math.cos(_theta),
        (minuteLineRadius -
                ((minute % 15 == 0)
                    ? _minuteLineDivBy15Len
                    : (minute % 5 == 0)
                        ? _minuteLineDivBy5Len
                        : _minuteLineLength)) *
            math.sin(_theta));
  }

  void _drawMinuteText({required int minute, required Canvas canvas}) {
    //((minute + 15) % 60)
    TextSpan span = new TextSpan(style: new TextStyle(color: Colors.black, fontSize: 12.0), text: minute.toString());
    TextPainter tp = new TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout(minWidth: 16);
    tp.size;

    final Offset _offsetTwo =
        _getInnerPointOfTheMinuteLine(minute: minute, minuteLineRadius: _minuteLineExtremePointRadius);

    tp.paint(canvas, Offset(_offsetTwo.dx - 8, _offsetTwo.dy));
  }

  // void _drawMinutesPointer(Canvas canvas, double side) {
  //   final Paint _paint = Paint()
  //     ..style = PaintingStyle.fill
  //     ..strokeWidth = 2
  //     ..strokeCap = ui.StrokeCap.round
  //     ..color = Colors.white;
  //
  //   canvas.translate(side / 2, side / 2);
  //   canvas.scale(1, -1);
  //   canvas.drawLine(Offset(0, 0), Offset(100, 50), _paint);
  // }

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
