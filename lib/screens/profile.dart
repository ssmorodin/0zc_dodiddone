import 'dart:io';

import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../pages/login_page.dart';
import '../services/firebase_auth.dart';
import '../utils/image_picker_util.dart'; // Импортируем ImagePickerUtil

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _authService = AuthService(); // Создаем экземпляр AuthenticationService
  String? _userEmail; // Переменная для хранения email пользователя
  String? _userAvatarUrl; // Переменная для хранения URL аватара пользователя
  final ImagePickerUtil _imagePicker = ImagePickerUtil(); // Создаем экземпляр ImagePickerUtil

  @override
  void initState() {
    super.initState();
    _getUserData(); // Получаем данные пользователя при инициализации
  }

  Future<void> _getUserData() async {
    // Получаем email пользователя
    _userEmail = await _authService.getUserEmail();
    // Получаем URL аватара пользователя (если он есть)
    _userAvatarUrl = await _authService.getUserAvatarUrl();
    setState(() {}); // Обновляем состояние, чтобы отобразить полученные данные
  }

  // Функция для выбора изображения
  Future<void> _pickImage() async {
    // Выбираем изображение из галереи
    final File? image = await _imagePicker.pickImageFromGallery();
    if (image != null) {
      // Если изображение выбрано, обновляем аватар пользователя
      await _authService.updateUserAvatar(image);
      // Обновляем URL аватара
      _userAvatarUrl = await _authService.getUserAvatarUrl();
      setState(() {}); // Обновляем состояние, чтобы отобразить новый аватар
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Аватар
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _userAvatarUrl != null
                      ? NetworkImage(_userAvatarUrl!) // Используем NetworkImage для аватара из Firebase
                      : const AssetImage('assets/person.png'), // Используем локальный аватар, если URL аватара не найден
                ),
                Positioned(
                  bottom: -16,
                  right: -16,
                  child: IconButton(
                    onPressed: _pickImage, // Вызываем _pickImage при нажатии на кнопку
                    icon: const Icon(Icons.photo_camera),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Почта
            Text(
              _userEmail ?? 'Неизвестно', // Отображаем email пользователя, если он получен
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            // Кнопка подтверждения почты (отображается, если почта не подтверждена)
            if (!_authService.isEmailVerified()) // Используем isEmailVerified()
              ElevatedButton(
                onPressed: () async {
                  // Отправляем запрос на подтверждение почты
                  await _authService.sendEmailVerification();
                  // Покажем диалог с сообщением о том, что письмо отправлено
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Подтверждение почты'),
                      content: const Text(
                          'Письмо с подтверждением отправлено на ваш адрес.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                          ),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                      DoDidDoneTheme.lightTheme.colorScheme.secondary,
                ),
                child: const Text('Подтвердить почту'),
              ),
            const SizedBox(height: 20),
            // Кнопка выхода из профиля
            ElevatedButton(
              onPressed: () async {
                // Выход из профиля
                await _authService.signOut();
                // Переход на страницу входа
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                // backgroundColor: Colors.red, // Красный цвет для кнопки выхода
              ),
              child: const Text('Выйти'),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import '../theme/theme.dart';
// import '../pages/login_page.dart';
// import '../services/firebase_auth.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final _authService = AuthService(); // Создаем экземпляр AuthenticationService
//   String? _userEmail; // Переменная для хранения email пользователя
//   String? _userAvatarUrl; // Переменная для хранения URL аватара пользователя

//   @override
//   void initState() {
//     super.initState();
//     _getUserData(); // Получаем данные пользователя при инициализации
//   }

//   Future<void> _getUserData() async {
//     // Получаем email пользователя
//     _userEmail = await _authService.getUserEmail();
//     // Получаем URL аватара пользователя (если он есть)
//     _userAvatarUrl = await _authService.getUserAvatarUrl();
//     setState(() {}); // Обновляем состояние, чтобы отобразить полученные данные
//   }

//   @override
//   Widget build(BuildContext context) {
//     final primaryColor = Theme.of(context).primaryColor;
//     final secondaryColor = Theme.of(context).colorScheme.secondary;

//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Аватар
//             Stack(
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: _userAvatarUrl != null
//                       ? NetworkImage(_userAvatarUrl!) // Используем NetworkImage для аватара из Firebase
//                       : const AssetImage('assets/person.png'), // Используем локальный аватар, если URL аватара не найден
//                 ),
//                 Positioned( 
//                   bottom: -16,
//                   right: -16, 
//                   child: IconButton(onPressed: () {}, icon: Icon(Icons.photo_camera)))
//               ], 
//             ),
//             const SizedBox(height: 20),
//             // Почта
//             Text(
//               _userEmail ?? 'Неизвестно', // Отображаем email пользователя, если он получен
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 10),
//             // Кнопка подтверждения почты (отображается, если почта не подтверждена)
//             if (!_authService.isEmailVerified()) // Используем isEmailVerified()
//               ElevatedButton(
//                 onPressed: () async {
//                   // Отправляем запрос на подтверждение почты
//                   await _authService.sendEmailVerification();
//                   // Покажем диалог с сообщением о том, что письмо отправлено
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: const Text('Подтверждение почты'),
//                       content: const Text(
//                           'Письмо с подтверждением отправлено на ваш адрес.'),
//                       actions: [
//                         TextButton(
//                           onPressed: () => Navigator.pushReplacement(
//                             context, 
//                             MaterialPageRoute(
//                               builder: (context) => const LoginPage())),
//                           child: const Text('OK'),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: DoDidDoneTheme.lightTheme.colorScheme.secondary,
//                 ),
//                 child: const Text('Подтвердить почту'),
//               ),
//             const SizedBox(height: 20),
//             // Кнопка выхода из профиля
//             ElevatedButton(
//               onPressed: () async {
//                 // Выход из профиля
//                 await _authService.signOut();
//                 // Переход на страницу входа
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginPage()),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 // backgroundColor: Colors.red, // Красный цвет для кнопки выхода
//               ),
//               child: const Text('Выйти'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
