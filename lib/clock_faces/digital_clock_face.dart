import 'package:clock_app/core/clock/digital_clock.dart';
import 'package:clock_app/core/clock/neon_clock.dart';
import 'package:flutter/material.dart';

class DigitalClockFace extends StatelessWidget {
  const DigitalClockFace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        child: Center(
          child: DigitalClock(
            clockRadius: 136,
          ),
        ),
      ),
    );
  }
}

class NeonClockFace extends StatelessWidget {
  const NeonClockFace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff012E33),
        child: Center(
          child: NeonClock(
            clockRadius: 136,
          ),
        ),
      ),
    );
  }
}
