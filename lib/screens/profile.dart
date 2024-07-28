import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../pages/login_page.dart';
import '../services/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _authService = AuthService(); // Создаем экземпляр AuthenticationService
  String? _userEmail; // Переменная для хранения email пользователя
  String? _userAvatarUrl; // Переменная для хранения URL аватара пользователя

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
            CircleAvatar(
              radius: 50,
              backgroundImage: _userAvatarUrl != null
                  ? NetworkImage(_userAvatarUrl!) // Используем NetworkImage для аватара из Firebase
                  : const AssetImage('assets/person.png'), // Используем локальный аватар, если URL аватара не найден
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
                              builder: (context) => const LoginPage())),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: DoDidDoneTheme.lightTheme.colorScheme.secondary,
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
