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
          TaskRow(title: 'Read 20 pages of the book about Flutter and write short notes from every chapter', isDone: true,),
          TaskRow(title: 'Second', isDone: false,),
          TaskRow(title: 'Third', isDone: false,),
          TaskRow(title: 'Third', isDone: true),
        ],
      ),
    );
  }
}

class TaskRow extends StatelessWidget {
  TaskRow({super.key, required this.title, required this.isDone});

  final String title;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.chevron_right,
          color: isDone ? Colors.grey : null,
        ),
        Icon(
          isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: isDone ? Colors.grey : null,
        ),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isDone ? Colors.grey : null,
            ),
          ),
        ),
      ],
    );
  }
}