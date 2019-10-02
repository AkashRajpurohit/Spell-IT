import 'package:flutter/material.dart';

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "This is game screen",
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