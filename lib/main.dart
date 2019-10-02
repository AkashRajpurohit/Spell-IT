import 'package:flutter/material.dart';
import 'package:spell_it/pages/home.dart';
import 'package:spell_it/pages/loading.dart';
import 'package:spell_it/pages/game.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.redAccent,
  ),
  initialRoute: '/home',
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/game': (context) => Game()
  },
));