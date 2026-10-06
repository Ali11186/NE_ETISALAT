import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 110),
      children: [
        const Text(
          'المهام',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'أنجز مهامك اليومية واجمع النقاط',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 22),
        ...app.tasks.map((task) => _taskCard(context, task, app)),
      ],
    );
  }

  Widget _taskCard(
    BuildContext context,
    AppTask task,
    AppProvider app,
  ) {
    final done = task.state == TaskState.completed;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: done
                  ? AppTheme.cyan.withOpacity(.16)
                  : AppTheme.blue.withOpacity(.12),
              child: Icon(
                done ? Icons.check : task.icon,
                color: done ? Colors.green : AppTheme.blue,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '+${task.points} نقطة',
                    style: const TextStyle(
                      color: AppTheme.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            FilledButton.tonal(
              onPressed: done || app.busy
                  ? null
                  : () => app.completeTask(task),
              child: Text(done ? 'تمت' : 'ابدأ'),
            ),
          ],
        ),
      ),
    );
  }
}
