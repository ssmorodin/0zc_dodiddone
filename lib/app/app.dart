import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: DoDidDoneTheme.lightTheme,
      home: const LoginPage(),
    );
  }
}
