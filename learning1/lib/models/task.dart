enum TaskStatus { notDone, inProgress, done }

class Task {
  Task({required this.title, required this.status});

  String title;
  TaskStatus status;
}
