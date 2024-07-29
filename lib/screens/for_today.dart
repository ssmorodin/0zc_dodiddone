import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/dialog_widget.dart';
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
      FirebaseFirestore.instance.collection('tasks');
  final _authService = AuthService();
  String? _userId;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> tasks = [];

  void _markTaskCompleted(String taskId) {
    _tasksCollection.doc(taskId).update({'completed': true, 'is_for_today': false}).then((_) {
      _updateTaskList();
    });
  }

  void _markTaskUnCompleted(String taskId) {
    _tasksCollection.doc(taskId).update({'completed': false, 'is_for_today': false}).then((_) {
      _updateTaskList();
    });
  }

  void _markTaskForToday(String taskId) {
    _tasksCollection.doc(taskId).update({'completed': false, 'is_for_today': true}).then((_) {
      _updateTaskList();
    });
  }

  void _updateTaskList() {
    setState(() {
      tasks.removeWhere((task) => task.data()['completed'] == true);
    });
  }

  Future<void> _getUserData() async {
    _userId = await _authService.getUserId();
    setState(() {});
  }

  // Функция для показа диалогового окна редактирования задачи
  void _showEditTaskDialog(String taskId, String title, String description, DateTime deadline) {
    showDialog(
      context: context,
      builder: (context) => DialogWidget(
        initialTitle: title,
        initialDescription: description,
        initialDeadline: deadline,
        taskId: taskId,
      ),
    );
  }

  // Функция для удаления задачи
  void _deleteTask(String taskId) {
    _tasksCollection.doc(taskId).delete().then((_) {
      _updateTaskList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _tasksCollection
        .where('userId', isEqualTo: _userId)
        .where('is_for_today', isEqualTo: true)
        .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Ошибка загрузки задач'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final tasks = snapshot.data!.docs;

            if (tasks.isEmpty) {
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
                    ],
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final taskData = tasks[index].data();
                  final taskId = tasks[index].id;
                    return TaskItem(
                    title: taskData['title'] ?? '',
                    description: taskData['description'] ?? '',
                    deadline: (taskData['deadline'] as Timestamp?)?.toDate() ?? DateTime.now(),
                    taskId: taskId,
                    toLeft: () => _markTaskUnCompleted(taskId),
                    toRight: () => _markTaskCompleted(taskId),
                  onEdit: () => _showEditTaskDialog(
                      taskId,
                      taskData['title'],
                      taskData['description'],
                      (taskData['deadline'] as Timestamp?)?.toDate() ??
                          DateTime.now()),
                  onDelete: () => _deleteTask(taskId),
                );
                  },
              );
            }
        }
      ); 
   }
}