import 'package:flutter/material.dart';

enum TaskStatus { notDone, inProgress, done }

List<Task> tasks = [
  Task(title: 'Deal with finances', status: TaskStatus.done),
  Task(title: 'Deal with finances', status: TaskStatus.notDone),
  Task(
    title:
      'very weirdly long sentence, just to test our app again, in case of way too long titles. Hope it works just fine.',
    status: TaskStatus.notDone,
  ),
  Task(title: 'Help the dog', status: TaskStatus.inProgress),
  Task(title: 'WHat r we doin', status: TaskStatus.notDone),
];

void main() {
  runApp(MaterialApp(home: CalendarPage()));
}

class CalendarPage extends StatelessWidget {
  CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Today')),
      body: Column(children: [for (Task task in tasks) TaskRow(task: task)]),
    );
  }
}

class TaskRow extends StatefulWidget {
  TaskRow({super.key, required this.task});

  final Task task;

  @override
  State<TaskRow> createState() => _TaskRowState();
}

class _TaskRowState extends State<TaskRow> {
  TaskStatus status = TaskStatus.notDone;

  @override
  void initState() {
    super.initState();
    status = widget.task.status;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDone = status == TaskStatus.done;

    return Row(
      children: [
        Icon(Icons.chevron_right, color: isDone ? Colors.grey : null),
        IconButton(
          icon: Icon(switch (status) {
            TaskStatus.notDone => Icons.check_box_outline_blank,
            TaskStatus.inProgress => Icons.indeterminate_check_box,
            TaskStatus.done => Icons.check_box,
          }, color: isDone ? Colors.grey : null),
          onPressed: () {
            setState(() {
              status = switch (status) {
                TaskStatus.notDone => TaskStatus.inProgress,
                TaskStatus.inProgress => TaskStatus.done,
                TaskStatus.done => TaskStatus.notDone,
              };
            });
          },
        ),
        Expanded(
          child: Text(
            widget.task.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: isDone ? Colors.grey : null),
          ),
        ),
      ],
    );
  }
}

class Task {
  Task({required this.title, required this.status});

  final String title;
  final TaskStatus status;
}
