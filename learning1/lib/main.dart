import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CalendarPage(),
  ));
}

class CalendarPage extends StatelessWidget {
  CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('First'),
            Text('Second'),
            Text('Third'),
          ],
        ),
      ),
    );
  }
}
