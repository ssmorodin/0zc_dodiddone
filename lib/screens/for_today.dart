import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/task_item.dart';
import '../services/firebase_auth.dart';

class ForTodayPage extends StatefulWidget {
  const ForTodayPage({super.key});

  @override
  State<ForTodayPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<ForTodayPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference<Map<String, dynamic>> _tasksCollection =
      FirebaseFirestore.instance.collection('tasks'); // Изменили тип
  final _authService = AuthService(); // Создаем экземпляр AuthenticationService
  String? _userId; // Переменная для хранения ID пользователя

  @override
  void initState() {
    super.initState();
    _getUserData(); // Получаем данные пользователя при инициализации
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> tasks = []; // Список задач

  void _markTaskCompleted(String taskId) {
    _tasksCollection.doc(taskId).update({'completed': true, 'is_for_today': false}).then((_) {
      _updateTaskList(); // Обновляем список задач
    });
  }

  void _markTaskUnCompleted(String taskId) {
    _tasksCollection.doc(taskId).update({'completed': false, 'is_for_today': false}).then((_) {
      _updateTaskList(); // Обновляем список задач
    });
  }

  void _markTaskForToday(String taskId) {
    _tasksCollection.doc(taskId).update({'completed': false, 'is_for_today': true}).then((_) {
      _updateTaskList(); // Обновляем список задач
    });
  }

  void _updateTaskList() {
    setState(() {
      tasks.removeWhere((task) => task.data()['completed'] == true);
    });
  }

  Future<void> _getUserData() async {
    // Получаем ID пользователя
    _userId = await _authService.getUserId();
    setState(() {}); // Обновляем состояние, чтобы отобразить полученные данные
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _tasksCollection
        .where('userId', isEqualTo: _userId)// Фильтруем задачи по ID пользователя
        .where('is_for_today', isEqualTo: true)// Фильтруем задачи от завершенных
        .snapshots(),
        builder: (context, snapshot) {
          // Вставьте эти строки для отладки
          print('snapshot.hasError: ${snapshot.hasError}');
          print('snapshot.connectionState: ${snapshot.connectionState}');
          print('snapshot.data: ${snapshot.data}');

          if (snapshot.hasError) {
            return const Center(child: Text('Ошибка загрузки задач'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final tasks = snapshot.data!.docs;

            if (tasks.isEmpty) {
              // Если задач нет, показываем сообщение
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Все сделано, время отдыхать..\n А может создадим новую задачу?',
                        style: TextStyle(fontSize: 20),
                      ),
                      // Убрали кнопку "Создать новую задачу"
                    ],
                  ),
                ),
              );
            } else {
              // Если есть задачи, отображаем их
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final taskData = tasks[index].data();
                  final taskId = tasks[index].id;
                    return TaskItem(
                    title: taskData['title'] ?? '',
                    description: taskData['description'] ?? '',
                    deadline: (taskData['deadline'] as Timestamp?)?.toDate() ?? DateTime.now(),
                    taskId: taskId, // Передаем ID задачи
                    toLeft: () => _markTaskUnCompleted(taskId),
                    toRight: () => _markTaskCompleted(taskId),
                    );
                  },

              );
            }
        }
      ); 
   }
}
