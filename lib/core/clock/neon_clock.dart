import 'package:clock_app/core/clock/arc_hand.dart';
import 'package:flutter/material.dart';

import 'digital_clock_text.dart';

const Color _color = Color(0xffEFDD21);

class NeonClock extends StatefulWidget {
  final double clockRadius;
  const NeonClock({Key? key, required this.clockRadius}) : super(key: key);

  @override
  _NeonClockState createState() => _NeonClockState();
}

class _NeonClockState extends State<NeonClock> {
  late DateTime _currentTime;
  late final Stream<DateTime> _timer;
  @override
  void initState() {
    _currentTime = DateTime.now();
    _timer = Stream.periodic(Duration(seconds: 1), (second) {
      _currentTime = DateTime.now();
      return _currentTime;
    }).asBroadcastStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (widget.clockRadius * 2),
      width: (widget.clockRadius * 2),
      child: StreamBuilder(
        stream: _timer,
        builder: (context, snapshot) => CustomPaint(
          size: Size(widget.clockRadius * 2, widget.clockRadius * 2),
          painter: ArcHand(value: _currentTime.hour / 24, arcColor: _color, enableNeonEffect: true),
          // painter: ArcHand(value: _currentTime.hour / 24, arcColor: Color(0xff23dcd6)),
          child: DigitalClockText(
            dateTime: _currentTime,
            hourColor: _color,
            minuteColor: _color,
            secondColor: _color,
          ),
        ),
      ),
    );
  }
}
