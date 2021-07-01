import 'package:clock_app/clock_faces/samsung_clock_face.dart';
import 'package:flutter/material.dart';

import 'clock_faces/material_clock_face.dart';

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
    return PageView(
      children: [
        MaterialClockFace(),
        SamsungClockFace(),
      ],
    );
  }
}
