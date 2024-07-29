import 'package:flutter/material.dart';
import 'package:zc_dodiddone/screens/profile.dart';
import '../pages/main_page.dart';
import '../services/firebase_auth.dart';
import '../theme/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  @override
  Widget build(BuildContext context) {
    final primaryColor = DoDidDoneTheme.lightTheme.primaryColor;
    final secondaryColor = DoDidDoneTheme.lightTheme.colorScheme.secondary;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Прозрачный AppBar
        elevation: 0, // Убираем тень
        title: const Text('Профиль'),
      ) ,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
          child: ProfileScreen(),
        ),
      ),
    );
  }
}