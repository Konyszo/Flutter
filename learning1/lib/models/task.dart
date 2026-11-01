enum TaskStatus { notDone, inProgress, done }

class Task {
  Task({required this.title, required this.status, List<Task>? subtasks}) : subtasks = subtasks ?? [];

  String title;
  TaskStatus status;
  List<Task> subtasks;
  bool isExpanded = false;
}

class TaskEntry {
  TaskEntry({required this.task, required this.depth, required this.siblings});

  final Task task;
  final int depth;
  final List<Task> siblings;
}
