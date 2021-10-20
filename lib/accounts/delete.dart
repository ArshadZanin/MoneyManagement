// Flutter imports:
import 'package:flutter/material.dart';

class DeleteData extends StatelessWidget {
  const DeleteData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020925),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF020925),
        title: const Text(
          "Delete",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
