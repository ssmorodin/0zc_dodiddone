import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/login_page.dart';
import '../pages/main_page.dart';
import '../theme/theme.dart';
import '../services/firebase_auth.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthService _authService;
  User? _user;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    _user = _authService.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Do-Did-Done',
      theme: DoDidDoneTheme.lightTheme,
      home: _user != null ? const MainPage() : const LoginPage(),
    );
  }
}