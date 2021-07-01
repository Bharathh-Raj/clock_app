import 'package:clock_app/clock_faces/samsung_watch_face/samsung_watch.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        body: Center(
          child: SamsungWatch(
            clockRadius: 150,
            hourHandLength: 75,
            minuteHandLength: 90,
            secondHandLength: 100,
            showClockFrame: true,
            clockFrameStrokeWidth: 8,
          ),
        ));
  }
}
