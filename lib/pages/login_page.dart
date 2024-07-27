import 'package:flutter/material.dart';
import 'package:zc_dodiddone/pages/main_page.dart';
import 'package:zc_dodiddone/theme/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true; // Флаг для определения режима (вход/регистрация)
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _checkPasswordController = TextEditingController();
    

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _checkPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = DoDidDoneTheme.lightTheme.primaryColor;
    final secondaryColor = DoDidDoneTheme.lightTheme.colorScheme.secondary;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: isLogin
                ? [
                    secondaryColor,
                    primaryColor,
                  ]
                : [
                    primaryColor,
                    secondaryColor,
                  ],
            stops: const [0.1, 0.9], // Основной цвет занимает 90%
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png', // Замените на правильный путь к файлу
                    height: 60, // Устанавливаем высоту изображения
                  ),
                  const SizedBox(width: 8),
                  // Добавляем текст "zerocoder"
                  const Text(
                    'zerocoder',
                    style: TextStyle(
                      fontSize: 62,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Белый цвет текста
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
                Center( // Добавлено Center
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'Do',
                          style: TextStyle(color: primaryColor),
                        ),
                        const TextSpan(
                          text: 'Did',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: 'Done',
                          style: TextStyle(color: secondaryColor),
                        ),
                      ],
                    ),
                  ),                
                ),
                const SizedBox(height: 50),
                Center(
                  child: Text(
                      isLogin ? 'Вход' : 'Регистрация',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Белый цвет текста
                      ),
                    ),
                ),
                 const SizedBox(height: 16), 
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white, // Изменено
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите email';
                    }
                    if (!value.contains('@')) {
                      return 'Неверный формат email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white, // Изменено
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите пароль';
                    }
                    return null;
                  },
                ),
                if (!isLogin) 
                const SizedBox(height: 16),
                if (!isLogin) 
                TextFormField(
                    controller: _checkPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white, // Изменено
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите пароль';
                      }
                      return null;
                    },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {        
                    // if (_formKey.currentState!.validate()) {
                      // Обработка входа/регистрации
                      Navigator.pushReplacement(context, 
                          MaterialPageRoute(builder: (context) => const MainPage()));  
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: isLogin ? secondaryColor : primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(isLogin ? 'Войти' : 'Зарегистрироваться'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    // Переход на другой фрейм
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      color: Colors.white, // Изменено
                      fontSize: 16,
                    ),
                  ),
                  child: Text(isLogin
                      ? 'Еще нет аккаунта...'
                      : 'Уже есть аккаунт...',
                      style: const TextStyle(
                        color: Colors.white, // Изменено
                      ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
