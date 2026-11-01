import 'package:flutter/material.dart';

enum TaskStatus { notDone, inProgress, done }

void main() {
  runApp(MaterialApp(home: CalendarPage()));
}

class CalendarPage extends StatefulWidget {
  CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Task? focusedTask;

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

  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void showTaskDialog({Task? task}) {
    if (task != null) {
      controller.text = task.title;
    } 

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(task == null ? 'Create Task' : 'Edit Task'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: 'your task name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.clear();
                Navigator.pop(context);
              }, 
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  setState(() {
                    if (task == null) {
                      tasks.add(
                        Task(
                          title: controller.text.trim(), 
                          status: TaskStatus.notDone,
                        )
                      );
                    } else {
                      task.title = controller.text.trim();
                    }
                  });
                  controller.clear();
                  Navigator.pop(context);
                } 
              }, 
              child: Text(task == null ? 'Add' : 'Save')
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Today')),
      body: ListView.builder(
        padding: EdgeInsets.only(bottom: 50),
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          final Task task = tasks[index];
          return TaskRow(
            key: ValueKey(task),
            task: task,
            isFocused: task == focusedTask,
            onTap:() {
              setState(() {
                focusedTask = task == focusedTask ? null : task;
              });
            },
            onDelete: () {
              setState((){
                tasks.remove(task);
                focusedTask = null;
              });
            },
            onStatusTap:() {
              setState(() {
                task.status = switch (task.status) {
                  TaskStatus.notDone => TaskStatus.inProgress,
                  TaskStatus.inProgress => TaskStatus.done,
                  TaskStatus.done => TaskStatus.notDone,
                };
              });
            },
            onEdit: () {
              showTaskDialog(task: task);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showTaskDialog();
        },
        child: Icon(Icons.add,),
      ),
    );
  }
}

class TaskRow extends StatelessWidget {
  const TaskRow({
    super.key, 
    required this.task, 
    required this.isFocused, 
    required this.onTap, 
    required this.onDelete,
    required this.onStatusTap,
    required this.onEdit,
  });

  final Task task;
  final bool isFocused;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onStatusTap;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final bool isDone = task.status == TaskStatus.done;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        color: isFocused ? Colors.blue.shade50 : null,
        child: Row(
          children: [
            Icon(Icons.chevron_right, color: isDone ? Colors.grey : null),
            IconButton(
              icon: Icon(switch (task.status) {
                TaskStatus.notDone => Icons.check_box_outline_blank,
                TaskStatus.inProgress => Icons.indeterminate_check_box,
                TaskStatus.done => Icons.check_box,
              }, color: isDone ? Colors.grey : null),
              onPressed: onStatusTap,
            ),
            Expanded(
              child: Text(
                task.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: isDone ? Colors.grey : null),
              ),
            ),
            if (isFocused) IconButton(
              onPressed: onEdit,
              icon: Icon(
                Icons.edit,
                color: Colors.blue,
              ),
            ),
            if (isFocused) IconButton(
              onPressed: onDelete,
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  Task({required this.title, required this.status});

  String title;
  TaskStatus status;
}
