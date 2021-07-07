import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

class ArcHand extends CustomPainter {
  final double value;
  final Color arcColor;
  final double _arcSweep;
  final bool enableNeonEffect;

  static const double _twoPi = math.pi * 2.0;
  static const double _epsilon = .001;
  static const double _sweep = _twoPi - _epsilon;

  ArcHand({required this.value, required this.arcColor, this.enableNeonEffect = false})
      : _arcSweep = value.clamp(0.0, 1.0) * _sweep;

  @override
  void paint(Canvas canvas, Size size) {
    if (enableNeonEffect) {
      Path path = Path();
      path.addArc(Offset.zero & size, -math.pi / 2, _arcSweep);
      Paint _shadowPaint = Paint()
        ..color = arcColor.withOpacity(0.4)
        ..style = PaintingStyle.stroke
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4)
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 18;
      canvas.drawPath(path, _shadowPaint);
    }
    Paint _paint = Paint()
      ..color = arcColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      // ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 6;
    canvas.drawArc(Offset.zero & size, -math.pi / 2, _arcSweep, false, _paint);
  }

  @override
  bool shouldRepaint(covariant ArcHand oldDelegate) => value != oldDelegate.value;
}
