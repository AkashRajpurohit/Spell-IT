import 'package:flutter/material.dart';

class Alert {
  Future<void> showAlert(
    BuildContext context,
    String title,
    String content
  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold
            ),
          ),
          content: Text(
            content,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic
            )
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
}