import 'package:clock_app/core/clock/clock.dart';
import 'package:flutter/material.dart';

class SamsungClockFace extends StatelessWidget {
  const SamsungClockFace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      child: Center(
        child: Clock(
          clockRadius: 120,
          hourHandLength: 60,
          minuteHandLength: 80,
          secondHandLength: 85,
          gradientColorList: [Color(0xff555555), Color(0xff3D3D3D)],
          hourHandStrokeWidth: 6,
          minuteHandStrokeWidth: 6,
          secondHandStrokeWidth: 2,
        ),
      ),
    );
  }
}
