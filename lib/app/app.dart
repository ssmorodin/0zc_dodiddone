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
  late final AuthService _authService; // Declare as late
  User? _user; // Use a private variable

  @override
  void initState() {
    super.initState();
    _authService = AuthService(); // Initialize AuthService
    _user = _authService.currentUser; // Get the current user
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Do-Did-Done',
      theme: DoDidDoneTheme.lightTheme,
      home: _user != null ? const MainPage() : const LoginPage(),
    );
  }
}

