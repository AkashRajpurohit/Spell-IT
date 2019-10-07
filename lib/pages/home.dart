import 'package:flutter/material.dart';
import 'package:spell_it/services/level.dart';

class Home extends StatelessWidget {

  final List <Level> levels = [
    Level(name: "Easy", number: 1, color: Colors.green),
    Level(name: "Medium", number: 2, color: Colors.greenAccent),
    Level(name: "Hard", number: 3, color: Colors.blueAccent),
    Level(name: "Extreme", number: 4, color: Colors.red)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spell-IT"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: levels.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              color: levels[index].color,
              child: ListTile(
                onTap: () { print(index); },
                title: Text("${levels[index].name}"),
              ),
            ),
          );
        },
      )
    );
  }
}