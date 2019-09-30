import 'package:flutter/material.dart';

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Text(
          "Loading...",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0
          ),
        )
      )
    );
  }
}