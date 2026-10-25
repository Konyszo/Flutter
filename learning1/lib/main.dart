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
      body: Column(
        children: [
          TaskRow(title: 'First'),
          TaskRow(title: 'Second'),
          TaskRow(title: 'Third'),
        ],
      ),
    );
  }
}

class TaskRow extends StatelessWidget {
  TaskRow({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.chevron_right),
        Icon(Icons.check_box_outline_blank),
        Text(title),
      ],
    );
  }
}