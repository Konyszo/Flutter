import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Moja aplikacja'),
        ),
        body: Column(
          children: [
            Text("Witaj"),
            Text('w Fluterze'),
            Greeting(name: "Adrain"),
            Greeting(name: "Ania"),
            Greeting(name: "Brian"),
            Row(
              children: [
                Icon(Icons.star),
                Icon(Icons.favorite),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Greeting extends StatelessWidget {
  const Greeting({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    print('build: $name');
    return Text('Cześć, $name!');
  }
}
