import 'package:flutter/material.dart';
import '../pages/main_page.dart';
import '../services/firebase_auth.dart';
import '../theme/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _checkPasswordController = TextEditingController();
  final _authService = AuthService();

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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
              stops: const [0.1, 0.9],
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
                        'assets/logo.png',
                        height: 50,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'zerocoder',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 28,
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
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
                      fillColor: Colors.white,
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
                      fillColor: Colors.white,
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
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Пожалуйста, введите пароль';
                        }
                        if (value != _passwordController.text) {
                          return 'Пароли не совпадают';
                        }
                        return null;
                      },
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (isLogin) {
                          try {
                            await _authService.signInWithEmailAndPassword(
                                _emailController.text, _passwordController.text);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => const MainPage()));
                          } catch (e) {
                            print('Ошибка входа: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Ошибка входа: $e')),
                            );
                          }
                        } else {
                          try {
                            await _authService.registerWithEmailAndPassword(
                                _emailController.text, _passwordController.text);
                            await _authService.sendEmailVerification();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Регистрация успешна! Проверьте свою почту для подтверждения.')),
                            );
                          } catch (e) {
                            print('Ошибка регистрации: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Ошибка регистрации: $e')),
                            );
                          }
                        }
                      }
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
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    child: Text(isLogin
                        ? 'Еще нет аккаунта...'
                        : 'Уже есть аккаунт...',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}