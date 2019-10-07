import 'package:flutter/material.dart';
import 'package:spell_it/pages/home.dart';
import 'package:spell_it/pages/game.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primaryColor: Colors.redAccent,
  ),
  initialRoute: '/',
  routes: {
    '/': (context) => Home(),
    '/game': (context) => Game()
  },
));