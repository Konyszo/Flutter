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
            ProfileCard(name: "Adrain", age: 12, city: "Warsaw",),
            ProfileCard(name: "Brian", age: 25, city: "Berlin"),
            ProfileCard(name: "Crow", age: 16),
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

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.name, required this.age, this.city = "unknown"});

  final String name;
  final int age;
  final String city;
  
  @override
  Widget build(BuildContext context) {
    return Text("$name, $age lat, $city");
  }
}