import 'package:flutter/material.dart';
import 'package:spell_it/pages/home.dart';
import 'package:spell_it/pages/loading.dart';


void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.redAccent,
  ),
  initialRoute: '/',
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home()
  },
));