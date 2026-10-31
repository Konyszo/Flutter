import 'package:flutter/material.dart';

enum TaskStatus {
  notDone,
  inProgress,
  done,
}

void main() {
  runApp(MaterialApp(home: CalendarPage()));
}

class CalendarPage extends StatelessWidget {
  CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Today')),
      body: Column(
        children: [
          TaskRow(
            title:
                'Read 20 pages of the book about Flutter and write short notes from every chapter',
            status: TaskStatus.notDone,
          ),
          TaskRow(title: 'Second', status: TaskStatus.done),
          TaskRow(title: 'Third', status: TaskStatus.inProgress),
          TaskRow(title: 'Third', status: TaskStatus.done),
        ],
      ),
    );
  }
}

class TaskRow extends StatefulWidget {
  TaskRow({super.key, required this.title, required this.status});

  final String title;
  final TaskStatus status;

  @override
  State<TaskRow> createState() => _TaskRowState();
}

class _TaskRowState extends State<TaskRow> {
  TaskStatus status = TaskStatus.notDone;

  @override
  void initState() {
    super.initState();
    status = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDone = status == TaskStatus.done;

    return Row(
      children: [
        Icon(Icons.chevron_right, color: isDone ? Colors.grey : null),
        IconButton(
          icon: Icon(
            switch (status) {
              TaskStatus.notDone => Icons.check_box_outline_blank,
              TaskStatus.inProgress => Icons.indeterminate_check_box,
              TaskStatus.done => Icons.check_box,
            },
            color: isDone ? Colors.grey : null,
          ),
          onPressed: () {
            setState(() {
              status = switch (status) {
                TaskStatus.notDone => TaskStatus.inProgress,
                TaskStatus.inProgress => TaskStatus.done,
                TaskStatus.done => status = TaskStatus.notDone,
              };
            });
          },
        ),
        Expanded(
          child: Text(
            widget.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: isDone ? Colors.grey : null),
          ),
        ),
      ],
    );
  }
}
