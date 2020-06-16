import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bmicalculator/input_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(new MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(64, 98, 250, 1.0),
      ),
      home: InputPage(),
    );
  }
}


