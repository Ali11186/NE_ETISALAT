import 'package:flutter/material.dart';

enum TaskState { available, completed, locked }

class AppTask {
  const AppTask({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.icon,
    this.state = TaskState.available,
  });

  final String id;
  final String title;
  final String subtitle;
  final int points;
  final IconData icon;
  final TaskState state;

  AppTask copyWith({TaskState? state}) {
    return AppTask(
      id: id,
      title: title,
      subtitle: subtitle,
      points: points,
      icon: icon,
      state: state ?? this.state,
    );
  }
}
