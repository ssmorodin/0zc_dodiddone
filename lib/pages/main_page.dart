import 'package:flutter/material.dart';
import '../pages/profile_page.dart';
import '../screens/completed.dart';
import '../screens/all_tasks.dart';
import '../screens/for_today.dart';
import '../widgets/dialog_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    TasksPage(), // Создаем экземпляр TasksPage
    ForTodayPage(), // Создаем экземпляр ForTodayPage
    CompletedPage(), // Создаем экземпляр CompletedPage
    // ProfilePage(), // Создаем экземпляр ProfilePage
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Функция для показа диалогового окна добавления задачи
void _showAddTaskDialog() {
  showDialog(
    context: context,
    builder: (context) => DialogWidget(), // No need for onSubmit here
  );
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

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Прозрачный AppBar
        elevation: 0, // Убираем тень
        actions: [
          IconButton(
           onPressed: () {
           Navigator.push(context,
           MaterialPageRoute(builder: (context) => ProfilePage()));
          },
           icon: const Icon(
             Icons.person_2,
             color: Colors.white,
           ) // Icon
         ), // IconButton
         ],// IconButton
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: [
                    secondaryColor,
                    primaryColor,
                  ],
                  stops: const [0.1, 0.9], // Основной цвет занимает 90%
                ),
              ),
              child: Center(
                child: IndexedStack(
                  index: _selectedIndex,
                  children: [
                    // Задачи
                    _widgetOptions.elementAt(0),
                    // Сегодня
                    _widgetOptions.elementAt(1),
                    // Выполнено
                    _widgetOptions.elementAt(2),
                    // Профиль
                    // const ProfilePage(), // Отображаем profile_page при выборе "Профиль"
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Задачи',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Сегодня',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Выполнено',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   label: 'Профиль',
          // ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog, // Вызываем диалоговое окно при нажатии
        child: const Icon(Icons.add),
      ),
    );
  }
}
