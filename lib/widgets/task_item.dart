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
    Duration timeUntilDeadline = deadline.difference(DateTime.now());
    Color gradientStart;

    if (timeUntilDeadline.inDays < 1) {
      gradientStart = Colors.red; // Срочная
    } else if (timeUntilDeadline.inDays < 2) {
      gradientStart = Colors.yellow; // Средняя срочность
    } else {
      gradientStart = Colors.green; // Не срочная
    }

    return Card(
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
                borderRadius: BorderRadius.only(
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
                  // Кнопки "Редактировать" и "Удалить"
                  IconButton(
                    onPressed: () {
                      // Действие для "Редактировать"
                      print('Редактировать задачу: $title');
                    },
                    icon: const Icon(
                      Icons.edit, 
                      // color: Colors.brown,
                      ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Действие для "Удалить"
                      print('Удалить задачу: $title');
                    },
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
      
    );
  }
}

// import 'package:flutter/material.dart';

// class TaskItem extends StatelessWidget {
//   final String title;
//   final String description;
//   final DateTime deadline;

//   const TaskItem({
//     Key? key,
//     required this.title,
//     required this.description,
//     required this.deadline,
//   }) : super(key: key);

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
//                 ),
//                 borderRadius: BorderRadius.only(
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
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white, // Белый текст для контраста
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 8),
//                   Text(
//                     description,
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Дедлайн: ${deadline.day.toString().padLeft(2, '0')}.${deadline.month.toString().padLeft(2, '0')}.${deadline.year.toString().substring(2)} ${deadline.hour.toString().padLeft(2, '0')}:${deadline.minute.toString().padLeft(2, '0')}',
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
      
//     );
//   }
// }

