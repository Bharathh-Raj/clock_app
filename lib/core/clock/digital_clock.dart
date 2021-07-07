import 'package:clock_app/core/clock/arc_hand.dart';
import 'package:flutter/material.dart';

import 'digital_clock_text.dart';

const Color _hourColor = Color(0xff1bcae0);
const Color _minuteColor = Color(0xff5EDCEC);
const Color _secondColor = Color(0xffBBF0F7);

class DigitalClock extends StatefulWidget {
  final double clockRadius;
  const DigitalClock({Key? key, required this.clockRadius}) : super(key: key);

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
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
          painter: ArcHand(value: _currentTime.hour / 24, arcColor: _hourColor),
          // painter: ArcHand(value: _currentTime.hour / 24, arcColor: Color(0xff23dcd6)),
          child: Center(
            child: SizedBox(
              height: (widget.clockRadius * 2) - 24,
              width: (widget.clockRadius * 2) - 24,
              child: CustomPaint(
                painter: ArcHand(value: _currentTime.minute / 60, arcColor: _minuteColor),
                // painter: ArcHand(value: _currentTime.minute / 60, arcColor: Color(0xffcfe21d)),
                child: Center(
                  child: SizedBox(
                    height: (widget.clockRadius * 2) - 48,
                    width: (widget.clockRadius * 2) - 48,
                    child: CustomPaint(
                      painter: ArcHand(value: _currentTime.second / 60, arcColor: _secondColor),
                      // painter: ArcHand(value: _currentTime.second / 60, arcColor: Color(0xff1de230)),
                      child: DigitalClockText(
                        hourColor: _hourColor,
                        minuteColor: _minuteColor,
                        secondColor: _secondColor,
                        dateTime: _currentTime,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
