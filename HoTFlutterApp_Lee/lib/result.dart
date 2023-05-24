import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
            '메인 페이지',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
  }
}