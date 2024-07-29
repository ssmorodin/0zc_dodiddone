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
    TasksPage(),
    ForTodayPage(),
    CompletedPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

void _showAddTaskDialog() {
  showDialog(
    context: context,
    builder: (context) => const DialogWidget(),
  );
}

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
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
           onPressed: () {
           Navigator.push(context,
           MaterialPageRoute(builder: (context) => const ProfilePage()));
          },
           icon: const Icon(
             Icons.person_2,
             color: Colors.white,
           )
         ),
         ],
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
                  stops: const [0.1, 0.9],
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
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}