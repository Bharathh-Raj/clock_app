import 'package:clock_app/core/clock/clock.dart';
import 'package:flutter/material.dart';

class MaterialClockFace extends StatelessWidget {
  const MaterialClockFace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      child: Center(
        child: Clock(
          clockRadius: 100,
          hourHandLength: 50,
          minuteHandLength: 70,
          secondHandLength: 85,
          showClockFrame: true,
          showMinuteLines: false,
          clockFrameStrokeWidth: 24,
          gradientColorList: [Color(0xff555555), Color(0xff3D3D3D)],
          hourHandStrokeWidth: 14,
          minuteHandStrokeWidth: 14,
          secondHandStrokeWidth: 4,
          secondHandColor: Colors.red,
        ),
      ),
    );
  }
}
