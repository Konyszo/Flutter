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
            Row(
              children: [
                Icon(Icons.star),
                Icon(Icons.favorite),
                CounterCard(),
                CounterCard()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CounterCard extends StatefulWidget {
  const CounterCard({super.key});

  @override
  State<CounterCard> createState() => _CounterCardState();
}

class _CounterCardState extends State<CounterCard> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: $count'),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  count++;
                });
              }, 
              child: Text('+')
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (count >= 1) {
                    count--;
                  }
                });
              }, 
              child: Text('-')
            )
          ],
        )
      ],
    );
  }
}