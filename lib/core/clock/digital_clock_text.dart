import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DigitalClockText extends StatelessWidget {
  final DateTime dateTime;
  final Color hourColor;
  final Color minuteColor;
  final Color secondColor;
  final Color seperatorColor;

  DigitalClockText({
    required this.dateTime,
    required this.hourColor,
    required this.secondColor,
    required this.minuteColor,
    required this.seperatorColor,
  });

  @override
  Widget build(BuildContext context) {
    final Text _separatorText = Text(
      ":",
      style: TextStyle(color: seperatorColor, fontSize: 36),
      textAlign: TextAlign.center,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildText(dateTime.hour.toString(), hourColor),
        _separatorText,
        _buildText(dateTime.minute.toString(), minuteColor),
        _separatorText,
        _buildText(dateTime.second.toString(), secondColor),
      ],
    );
  }

  Widget _buildText(String text, Color color) {
    return SizedBox(
      height: 40,
      width: 62,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          // color: Color(0xffF9E31B),
          fontSize: 36,
        ),
      ),
    );
  }
}
