import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spell-IT"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "A App that helps you learn and have fun!",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey[600]
              ),
            )
          ],
        ),
      ),
    );
  }
}