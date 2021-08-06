import 'package:flutter/material.dart';
import 'package:flutter_application_4/screen/input_screen.dart';

import 'screen/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Список дел",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amberAccent,
      ),
      initialRoute: '/',
      routes: {'/': (context) => InputScreen(), '/todo': (context) => Home()},
    );
  }
}
