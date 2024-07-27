import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:zc_dodiddone/screens/all_tasks.dart';
import 'package:zc_dodiddone/screens/profile.dart'; // Импортируем profile_page

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    TasksPage(),
    Text('Сегодня'),
    Text('Выполнено'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Функция для показа диалогового окна
  void _showAddTaskDialog() {
    // Используем GlobalKey для управления состоянием формы
    final formKey = GlobalKey<FormState>();
    // Переменная для хранения выбранной даты
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Добавить задачу'),
          content: Form(
            key: formKey, // Привязываем форму к GlobalKey
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      const Text('Название задачи'),
                    ],
                  ),
                ),
                TextFormField(
                  // decoration: const InputDecoration(
                  //   labelText: 'Название задачи',
                  // ),
                  // ... (добавьте обработку ввода названия задачи)
                ),
                 Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      const Text('Описание'),
                    ],
                  ),
                ),
                TextFormField(
                  // decoration: const InputDecoration(
                  //   labelText: 'Описание',
                  // ),
                  // ... (добавьте обработку ввода описания задачи)
                ),
                // Поле для выбора даты дедлайна
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      const Text('Дедлайн'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Column(
                    children: <Widget>[
                      // const Text('Дедлайн'),
                      DateTimeField(
                        format: DateFormat('dd.MM.yy HH:mm'),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100),
                          ).then((date) {
                            if (date != null) {
                              return showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                              ).then((time) {
                                return DateTimeField.combine(date, time);
                              });
                            }
                          });
                        },
                        onChanged: (DateTime? date) {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Закрыть диалоговое окно
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                // ... (обработайте ввод данных и добавьте задачу)
                Navigator.of(context).pop(); // Закрыть диалоговое окно
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent, // Прозрачный фон AppBar
      //   elevation: 0, // Убираем тень
      //   title: const Text('DoDidDone'),
      //   centerTitle: true,
      // ),
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
                    const ProfilePage(), // Отображаем profile_page при выборе "Профиль"
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
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
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


// import 'package:flutter/material.dart';
// import 'package:zc_dodiddone/screens/all_tasks.dart';
// import 'package:zc_dodiddone/screens/profile.dart'; // Импортируем profile_page
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart'; // Импортируем DateTimePickerFormField
// import 'package:intl/intl.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int _selectedIndex = 0;

//   static const List<Widget> _widgetOptions = <Widget>[
//     TasksPage(),
//     Text('Сегодня'),
//     Text('Выполнено'),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   // Функция для показа диалогового окна
//   void _showAddTaskDialog() {
//     // Используем GlobalKey для управления состоянием формы
//     final _formKey = GlobalKey<FormState>();
//     // Переменная для хранения выбранной даты
//     DateTime? _selectedDate;

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Добавить задачу'),
//           content: Form(
//             key: _formKey, // Привязываем форму к GlobalKey
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     labelText: 'Название задачи',
//                   ),
//                   // ... (добавьте обработку ввода названия задачи)
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     labelText: 'Описание',
//                   ),
//                   // ... (добавьте обработку ввода описания задачи)
//                 ),
//                 // Поле для выбора даты дедлайна
//                                 // Поле для выбора даты дедлайна
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16.0),
//                   child: DateTimePickerFormField( // Заменяем GestureDetector на DateTimePickerFormField
//                     decoration: const InputDecoration(
//                       labelText: 'Дедлайн',
//                     ),
//                     format: DateFormat('dd.MM.yyyy HH:mm'), // Формат даты и времени
//                     initialDate: DateTime.now().add(const Duration(days: 1)), // Текущая дата + 1 день
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime.now().add(const Duration(days: 365)),
//                     onChanged: (DateTime? date) {
//                       setState(() {
//                         _selectedDate = date;
//                       });
//                     },
//                   ),
//                 ),

//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Закрыть диалоговое окно
//               },
//               child: const Text('Отмена'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // ... (обработайте ввод данных и добавьте задачу)
//                 Navigator.of(context).pop(); // Закрыть диалоговое окно
//               },
//               child: const Text('Добавить'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final primaryColor = Theme.of(context).primaryColor;
//     final secondaryColor = Theme.of(context).colorScheme.secondary;

//     return Scaffold(
//       // extendBodyBehindAppBar: true,
//       // appBar: AppBar(
//       //   backgroundColor: Colors.transparent, // Прозрачный фон AppBar
//       //   elevation: 0, // Убираем тень
//       //   title: const Text('DoDidDone'),
//       //   centerTitle: true,
//       // ),
//       body: Column(
//         children: [
//           Expanded(
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   secondaryColor,
//                   primaryColor,              
//                 ],
//                 stops: const [0.1, 0.9], // Основной цвет занимает 90%
//               ),
//             ),
//             child: Center(
//             child: IndexedStack(
//                           index: _selectedIndex,
//                           children: [
//                             // Задачи
//                             _widgetOptions.elementAt(0),
//                             // Сегодня
//                             _widgetOptions.elementAt(1),
//                             // Выполнено
//                             _widgetOptions.elementAt(2),
//                             // Профиль
//                             ProfilePage(), // Отображаем profile_page при выборе "Профиль"
//                           ],
//                         ),
//              ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list),
//             label: 'Задачи',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today),
//             label: 'Сегодня',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.check_circle),
//             label: 'Выполнено',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Профиль',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showAddTaskDialog, // Вызываем диалоговое окно при нажатии
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }