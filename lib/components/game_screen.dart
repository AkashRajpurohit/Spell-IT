import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "A___P_A__",
            style: TextStyle(
              fontSize: 45.0,
              letterSpacing: 5.0
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.fromLTRB(60.0, 0.0, 60.0, 0.0),
            child: TextField(
              maxLength: 9,
              onChanged: (value) {
                print("Changed value: $value");
              },
              onSubmitted: (value) {
                print("Submitted value: $value");
              },
              style: TextStyle(
                fontSize: 30.0
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 100.0),
            height: 70.0,
            width: 70.0,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  print("Buttom");
                },
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.speaker_phone,
                  size: 35.0,
                ),
              )
            )
          )
        ],
      ),
    );
  }
}