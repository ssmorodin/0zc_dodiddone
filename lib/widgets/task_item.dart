import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final String description;
  final DateTime deadline;

  const TaskItem({
    Key? key,
    required this.title,
    required this.description,
    required this.deadline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Дедлайн: ${deadline.day.toString().padLeft(2, '0')}.${deadline.month.toString().padLeft(2, '0')}.${deadline.year.toString().substring(2)} ${deadline.hour.toString().padLeft(2, '0')}:${deadline.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
