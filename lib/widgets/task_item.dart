import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final String description;
  final DateTime deadline;
  final String taskId;
  final Function? onEdit; // Функция для редактирования
  final Function? onDelete;  // Функция для удаления
  final Function? toLeft; // Функция смахнуть влево
  final Function? toRight; // Функция смахнуть вправо

  const TaskItem({
    super.key,
    required this.title,
    required this.description,
    required this.deadline,
    required this.taskId,
    this.onEdit,
    this.onDelete,
    this.toLeft,
    this.toRight,
  });

  @override
  Widget build(BuildContext context) {
    Duration timeUntilDeadline = deadline.difference(DateTime.now());
    Color gradientStart;

    if (timeUntilDeadline.inDays < 1) {
      gradientStart = Colors.red; // Срочная
    } else if (timeUntilDeadline.inDays < 2) {
      gradientStart = Colors.yellow; // Средняя срочность
    } else {
      gradientStart = Colors.green; // Не срочная
    }

    return Dismissible(
      key: Key(taskId), // Используем taskId для уникального ключа
      background: Container(
        color: Colors.green, // Цвет смахнуть вправо
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.chevron_right_rounded, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.blue, // Цвет смахнуть влево
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.chevron_left_rounded, color: Colors.white),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          toLeft?.call();
        } else if (direction == DismissDirection.startToEnd) {
          toRight?.call();
        }
      },
      child: Card(
        color: Theme.of(context).cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [gradientStart, Colors.white],
                  stops: const [0.0, 0.3],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onEdit != null ? () => onEdit!() : null,
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                  IconButton(
                    onPressed: onDelete != null ? () => onDelete!() : null,
                    icon: const Icon(
                      Icons.delete,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Дедлайн: ${deadline.day.toString().padLeft(2, '0')}.${deadline.month.toString().padLeft(2, '0')}.${deadline.year.toString().substring(2)} ${deadline.hour.toString().padLeft(2, '0')}:${deadline.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}