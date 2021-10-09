import 'package:flutter/material.dart';
import 'package:money_management/home.dart';
import 'package:money_management/splash%20screen/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      checkerboardOffscreenLayers: true,
      debugShowCheckedModeBanner: false,
      title: 'Money Management',
      theme: ThemeData(
        fontFamily: 'Saira',
        primarySwatch: Colors.red,
      ),
      home: const SplashScreen1Sub(),

    );
  }
}