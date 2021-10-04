import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020925),
      appBar: AppBar(
        title: const Text("Help",style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF020925),
      ),
    );
  }
}
