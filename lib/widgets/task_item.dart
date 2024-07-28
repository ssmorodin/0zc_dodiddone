import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final String description;
  final DateTime deadline;
  final String taskId;
  final Function? onEdit; // Функция для редактирования
  final Function? onDelete;  // Функция для удаления
  final Function? toLeft; // Функция completed = true
  final Function? toRight; // Функция задача на сегодня

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
        color: Colors.green, // Цвет для "Задача на сегодня"
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.calendar_today, color: Colors.white), // Иконка календаря
      ),
      secondaryBackground: Container(
        color: Colors.blue, // Цвет для "Выполнено"
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.check_circle, color: Colors.white), // Иконка галочки
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          // Действие для "Задача на сегодня"
          toRight?.call(); // Вызываем функцию toRight
        } else if (direction == DismissDirection.startToEnd) {
          // Действие для "Выполнено"
          toLeft?.call(); // Вызываем функцию toLeft
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
                  colors: [gradientStart, Colors.white], // Используем gradientStart
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
                        // color: Colors.white, // Белый текст для контраста
                      ),
                    ),
                  ),
                  // Кнопки "Редактировать" и "Удалить" (вернули в рабочий код)
                  IconButton(
                    onPressed: onEdit != null ? () => onEdit!() : null, // Вызываем onEdit, если он не null
                    icon: const Icon(
                      Icons.edit,
                      // color: Colors.brown,
                    ),
                  ),
                  IconButton(
                    onPressed: onDelete != null ? () => onDelete!() : null, // Вызываем onDelete, если он не null
                    icon: const Icon(
                      Icons.delete,
                      // color: Colors.brown,
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


// import 'package:flutter/material.dart';

// class TaskItem extends StatelessWidget {
//   final String title;
//   final String description;
//   final DateTime deadline;
//   final String taskId;
//   final Function? onEdit; // Функция для редактирования
//   final Function? onDelete;  // Функция для удаления
//   final Function? toLeft; // Функция completed = true
//   final Function? toRight; // Функция задача на сегодня

//   const TaskItem({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.deadline,
//     required this.taskId,
//     this.onEdit,
//     this.onDelete,
//     this.toLeft,
//     this.toRight,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Duration timeUntilDeadline = deadline.difference(DateTime.now());
//     Color gradientStart;

//     if (timeUntilDeadline.inDays < 1) {
//       gradientStart = Colors.red; // Срочная
//     } else if (timeUntilDeadline.inDays < 2) {
//       gradientStart = Colors.yellow; // Средняя срочность
//     } else {
//       gradientStart = Colors.green; // Не срочная
//     }

//     return Dismissible(
//       key: Key(taskId), // Используем taskId для уникального ключа
//       background: Container(
//         color: Colors.green, // Цвет для "Задача на сегодня"
//         alignment: Alignment.centerRight,
//         padding: const EdgeInsets.only(right: 20),
//         child: const Icon(Icons.calendar_today, color: Colors.white), // Иконка календаря
//       ),
//       secondaryBackground: Container(
//         color: Colors.blue, // Цвет для "Выполнено"
//         alignment: Alignment.centerLeft,
//         padding: const EdgeInsets.only(left: 20),
//         child: const Icon(Icons.check_circle, color: Colors.white), // Иконка галочки
//       ),
//       onDismissed: (direction) {
//         if (direction == DismissDirection.endToStart) {
//           // Действие для "Задача на сегодня"
//           toRight?.call(); // Вызываем функцию toRight
//         } else if (direction == DismissDirection.startToEnd) {
//           // Действие для "Выполнено"
//           toLeft?.call(); // Вызываем функцию toLeft
//         }
//       },
//       child: Card(
//         color: Theme.of(context).cardColor,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [gradientStart, Colors.white], // Используем gradientStart
//                   stops: const [0.0, 0.3],
//                 ),
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   topRight: Radius.circular(12),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         // color: Colors.white, // Белый текст для контраста
//                       ),
//                     ),
//                   ),
//                   // Кнопки "Редактировать" и "Удалить" (убраны, так как теперь они в Dismissible)
//                   // ...
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 8),
//                   Text(
//                     description,
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Дедлайн: ${deadline.day.toString().padLeft(2, '0')}.${deadline.month.toString().padLeft(2, '0')}.${deadline.year.toString().substring(2)} ${deadline.hour.toString().padLeft(2, '0')}:${deadline.minute.toString().padLeft(2, '0')}',
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';

// class TaskItem extends StatelessWidget {
//   final String title;
//   final String description;
//   final DateTime deadline;
//   final String taskId;

//   const TaskItem({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.deadline,
//     required this.taskId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Duration timeUntilDeadline = deadline.difference(DateTime.now());
//     Color gradientStart;

//     if (timeUntilDeadline.inDays < 1) {
//       gradientStart = Colors.red; // Срочная
//     } else if (timeUntilDeadline.inDays < 2) {
//       gradientStart = Colors.yellow; // Средняя срочность
//     } else {
//       gradientStart = Colors.green; // Не срочная
//     }

//     return Card(
//       color: Theme.of(context).cardColor,
//       child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [gradientStart, Colors.white], // Используем gradientStart
//                   stops: const [0.0, 0.3],
//                 ),
//                 borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 topRight: Radius.circular(12),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         // color: Colors.white, // Белый текст для контраста
//                       ),
//                     ),
//                   ),
//                   // Кнопки "Редактировать" и "Удалить"
//                   IconButton(
//                     onPressed: () {
//                       // Действие для "Редактировать"
//                       print('Редактировать задачу: $title');
//                     },
//                     icon: const Icon(
//                       Icons.edit, 
//                       // color: Colors.brown,
//                       ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       // Действие для "Удалить"
//                       print('Удалить задачу: $title');
//                     },
//                     icon: const Icon(
//                       Icons.delete,
//                       // color: Colors.brown,
//                        ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 8),
//                   Text(
//                     description,
//                     style: const TextStyle(fontSize: 18),
//                    ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Дедлайн: ${deadline.day.toString().padLeft(2, '0')}.${deadline.month.toString().padLeft(2, '0')}.${deadline.year.toString().substring(2)} ${deadline.hour.toString().padLeft(2, '0')}:${deadline.minute.toString().padLeft(2, '0')}',
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
      
//     );
//   }
// }

