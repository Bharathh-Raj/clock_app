import 'dart:math' as math;
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';

class SamsungWatchFace extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    assert(size.height == size.width, "Height and width should be equal since the face is round");
    final double _side = size.height;
    _drawBaseCircle(canvas, _side);
    _drawMinutesPointer(canvas, _side);
    _drawCenterCircle(canvas, _side);
    // _drawHoursHand(canvas, _side);
    // _drawMinutesPointer(canvas, _side);
  }

  void _drawBaseCircle(Canvas canvas, double side) {
    final Paint _paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(side / 2, side),
        Offset(side / 2, 0),
        [Colors.cyan[400]!, Colors.cyan[100]!],
      )
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(side / 2, side / 2), 100, _paint);
  }

  void _drawMinutesPointer(Canvas canvas, double side) {
    final int _numberOfMintuesPointer = 60;
    final double _angleBetweenMinutePointers = (2 * math.pi) / _numberOfMintuesPointer;
    final double _minuteLineLength = 4;
    final double _minuteLineDivBy5Len = 7;
    final double _minuteLineDivBy15Len = 10;
    //TODO: leave some space around the minute line
    final double _radius = side / 2;
    print(_angleBetweenMinutePointers);
    final Paint _paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    //TODO:REFACTOR
    canvas.save();
    canvas.translate(_radius, _radius);
    canvas.scale(1, -1);
    for (int i = 0; i <= _numberOfMintuesPointer; i++) {
      final Offset _offsetOne = Offset(
          _radius * math.cos(_angleBetweenMinutePointers * i), _radius * math.sin(_angleBetweenMinutePointers * i));
      final Offset _offsetTwo = Offset(
          (_radius -
                  ((i % 15 == 0)
                      ? _minuteLineDivBy15Len
                      : (i % 5 == 0)
                          ? _minuteLineDivBy5Len
                          : _minuteLineLength)) *
              math.cos(_angleBetweenMinutePointers * i),
          (_radius -
                  ((i % 15 == 0)
                      ? _minuteLineDivBy15Len
                      : (i % 5 == 0)
                          ? _minuteLineDivBy5Len
                          : _minuteLineLength)) *
              math.sin(_angleBetweenMinutePointers * i));
      canvas.drawLine(_offsetOne, _offsetTwo, _paint);
    }
    canvas.restore();
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

  void _drawCenterCircle(Canvas canvas, double side) {
    final Paint _paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(side / 2, side / 2), 8, _paint);
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
