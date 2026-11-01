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

  void createTaskPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Task Creation'),
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
              child: Text('Cancel')
            ),
            TextButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  setState(() {
                    tasks.add(
                      Task(
                        title: controller.text.trim(), 
                        status: TaskStatus.notDone
                      )
                    );
                  });
                  controller.clear();
                  Navigator.pop(context);
                } 
              }, 
              child: Text('Add')
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createTaskPopUp();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TaskRow extends StatefulWidget {
  TaskRow({
    super.key, 
    required this.task, 
    required this.isFocused, 
    required this.onTap, 
    required this.onDelete
  });

  final Task task;
  final bool isFocused;
  final VoidCallback onTap;
  final VoidCallback onDelete;

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

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: Container(
        color: widget.isFocused ? Colors.blue.shade50 : null,
        child: Row(
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
            if (widget.isFocused) IconButton(
              onPressed: () {
                
              },
              icon: Icon(
                Icons.edit,
                color: Colors.blue,
              ),
            ),
            if (widget.isFocused) IconButton(
              onPressed: widget.onDelete,
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

  final String title;
  final TaskStatus status;
}
