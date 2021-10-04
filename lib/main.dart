import 'package:flutter/material.dart';
import 'package:money_management/home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Management',
      theme: ThemeData(
        fontFamily: 'Saira',
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),

    );
  }
}