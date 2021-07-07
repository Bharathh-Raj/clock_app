import 'package:clock_app/core/clock/analog_clock_hands.dart';
import 'package:clock_app/core/clock/base_clock.dart';
import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  final double clockRadius;
  final double spaceBeyondMinuteLine;
  final double minuteLineLength;
  final double minuteLineDivBy5Length;
  final double minuteLineDivBy15Length;
  final double hourHandLength;
  final double minuteHandLength;
  final double secondHandLength;
  final double hourHandStrokeWidth;
  final double minuteHandStrokeWidth;
  final double secondHandStrokeWidth;

  final bool showSecondHand;
  final bool showMinuteHand;
  final bool showHourHand;
  final bool showMinuteLines;

  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;

  final bool showClockFrame;
  final double clockFrameStrokeWidth;

  final List<Color> gradientColorList;

  final double centerCircleRadius;
  final Color centerCircleColor;

  final Color secondaryCircleColor;
  final double secondaryCircleRadius;

  const Clock({
    Key? key,
    required this.clockRadius,
    required this.gradientColorList,
    this.hourHandStrokeWidth = 6,
    this.minuteHandStrokeWidth = 6,
    this.secondHandStrokeWidth = 2,
    this.centerCircleRadius = 8,
    this.centerCircleColor = Colors.white,
    this.secondaryCircleRadius = 0,
    this.secondaryCircleColor = Colors.white,
    this.hourHandColor = Colors.white,
    this.minuteHandColor = Colors.white,
    this.secondHandColor = Colors.white,
    this.spaceBeyondMinuteLine = 4,
    this.minuteLineLength = 4,
    this.minuteLineDivBy5Length = 7,
    this.minuteLineDivBy15Length = 10,
    this.minuteHandLength = 0,
    this.hourHandLength = 0,
    this.secondHandLength = 0,
    this.showMinuteLines = true,
    this.showSecondHand = true,
    this.showMinuteHand = true,
    this.showHourHand = true,
    this.showClockFrame = false,
    this.clockFrameStrokeWidth = 2,
  }) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
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
          showMinuteLines: widget.showMinuteLines,
          clockRadius: widget.clockRadius,
          minuteLineLength: widget.minuteLineLength,
          minuteLineDivBy5Length: widget.minuteLineDivBy5Length,
          minuteLineDivBy15Length: widget.minuteLineDivBy15Length,
          spaceBeyondMinuteLine: widget.spaceBeyondMinuteLine,
          showClockFrame: widget.showClockFrame,
          clockFrameStrokeWidth: widget.clockFrameStrokeWidth,
          gradientColorList: widget.gradientColorList,
        ),
        willChange: false,
        child: StreamBuilder(
          stream: _timer,
          builder: (context, snapshot) {
            return CustomPaint(
              painter: AnalogClockHands(
                secondaryCircleColor: widget.secondaryCircleColor,
                secondaryCircleRadius: widget.secondaryCircleRadius,
                centerCircleColor: widget.centerCircleColor,
                centerCircleRadius: widget.centerCircleRadius,
                clockRadius: widget.clockRadius,
                dateTime: _currentTime,
                hourHandLength: widget.hourHandLength,
                minuteHandLength: widget.minuteHandLength,
                secondHandLength: widget.secondHandLength,
                showHourHand: widget.showHourHand,
                showMinuteHand: widget.showMinuteHand,
                showSecondHand: widget.showSecondHand,
                hourHandStrokeWidth: widget.hourHandStrokeWidth,
                minuteHandStrokeWidth: widget.minuteHandStrokeWidth,
                secondHandStrokeWidth: widget.secondHandStrokeWidth,
                hourHandColor: widget.hourHandColor,
                secondHandColor: widget.secondHandColor,
                minuteHandColor: widget.minuteHandColor,
              ),
              willChange: true,
            );
          },
        ),
      ),
    );
  }
}
