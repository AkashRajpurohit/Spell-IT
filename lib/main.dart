import 'package:flutter/material.dart';
import 'package:spell_it/pages/game.dart';
import 'package:spell_it/pages/home.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primaryColor: Colors.redAccent,
    fontFamily: 'Roboto'
  ),
  initialRoute: '/',
  routes: {
    '/': (context) => Home(),
    '/game': (context) => Game()
  },
));