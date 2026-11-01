import 'package:flutter/material.dart';

import '../models/task.dart';


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
            if (isFocused)
              IconButton(
                onPressed: onEdit,
                icon: Icon(Icons.edit, color: Colors.blue),
              ),
            if (isFocused)
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
