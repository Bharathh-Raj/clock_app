import 'package:clock_app/clock_faces/samsung_watch_face/samsung_watch_base_circle.dart';
import 'package:clock_app/clock_faces/samsung_watch_face/samsung_watch_hands.dart';
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
    _timer = Stream.periodic(const Duration(seconds: 1), (second) {
      _currentTime.add(const Duration(seconds: 1));
      return _currentTime;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.clockRadius * 2,
      width: widget.clockRadius * 2,
      child: CustomPaint(
        size: Size(widget.clockRadius * 2, widget.clockRadius * 2),
        painter: SamsungWatchBaseCircle(
          minuteLineLength: widget.minuteLineLength,
          minuteLineDivBy5Length: widget.minuteLineDivBy5Length,
          minuteLineDivBy15Length: widget.minuteLineDivBy15Length,
          spaceBeyondMinuteLine: widget.spaceBeyondMinuteLine,
        ),
        willChange: false,
        child: StreamBuilder(
          stream: _timer,
          builder: (context, snapshot) {
            return CustomPaint(
              painter: SamsungWatchHands(
                dateTime: _currentTime,
                hourHandLength: widget.hourHandLength,
                minuteHandLength: widget.minuteHandLength,
                secondHandLength: widget.secondHandLength,
              ),
              willChange: true,
            );
          },
        ),
      ),
    );
  }
}
