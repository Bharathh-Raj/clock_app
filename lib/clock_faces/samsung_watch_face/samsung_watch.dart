import 'package:clock_app/core/clock/base_clock.dart';
import 'package:clock_app/core/clock/clock_hands.dart';
import 'package:flutter/material.dart';

class SamsungWatch extends StatefulWidget {
  final double clockRadius;
  final double spaceBeyondMinuteLine;
  final double minuteLineLength;
  final double minuteLineDivBy5Length;
  final double minuteLineDivBy15Length;
  final double hourHandLength;
  final double minuteHandLength;
  final double secondHandLength;

  final bool showSecondHand;
  final bool showMinuteHand;
  final bool showHourHand;

  final bool showClockFrame;
  final double clockFrameStrokeWidth;

  const SamsungWatch({
    Key? key,
    required this.clockRadius,
    this.spaceBeyondMinuteLine = 4,
    this.minuteLineLength = 4,
    this.minuteLineDivBy5Length = 7,
    this.minuteLineDivBy15Length = 10,
    this.minuteHandLength = 0,
    this.hourHandLength = 0,
    this.secondHandLength = 0,
    this.showSecondHand = true,
    this.showMinuteHand = true,
    this.showHourHand = true,
    this.showClockFrame = false,
    this.clockFrameStrokeWidth = 2,
  }) : super(key: key);

  @override
  _SamsungWatchState createState() => _SamsungWatchState();
}

class _SamsungWatchState extends State<SamsungWatch> {
  late DateTime _currentTime;
  late final Stream<DateTime> _timer;
  @override
  void initState() {
    _currentTime = DateTime.now();
    _timer = Stream.periodic(Duration(seconds: 1), (second) {
      _currentTime = DateTime.now();
      return _currentTime;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (widget.clockRadius * 2) + widget.clockFrameStrokeWidth,
      width: (widget.clockRadius * 2) + widget.clockFrameStrokeWidth,
      child: CustomPaint(
        size: Size(widget.clockRadius * 2, widget.clockRadius * 2),
        painter: BaseClock(
          clockRadius: widget.clockRadius,
          minuteLineLength: widget.minuteLineLength,
          minuteLineDivBy5Length: widget.minuteLineDivBy5Length,
          minuteLineDivBy15Length: widget.minuteLineDivBy15Length,
          spaceBeyondMinuteLine: widget.spaceBeyondMinuteLine,
          showClockFrame: widget.showClockFrame,
          clockFrameStrokeWidth: widget.clockFrameStrokeWidth,
        ),
        willChange: false,
        child: StreamBuilder(
          stream: _timer,
          builder: (context, snapshot) {
            return CustomPaint(
              painter: ClockHands(
                clockRadius: widget.clockRadius,
                dateTime: _currentTime,
                hourHandLength: widget.hourHandLength,
                minuteHandLength: widget.minuteHandLength,
                secondHandLength: widget.secondHandLength,
                showHourHand: widget.showHourHand,
                showMinuteHand: widget.showMinuteHand,
                showSecondHand: widget.showSecondHand,
              ),
              willChange: true,
            );
          },
        ),
      ),
    );
  }
}
