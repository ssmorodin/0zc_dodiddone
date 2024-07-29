import 'dart:io';
import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../pages/login_page.dart';
import '../services/firebase_auth.dart';
import '../utils/image_picker_util.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _authService = AuthService();
  String? _userEmail;
  String? _userAvatarUrl;
  final ImagePickerUtil _imagePicker = ImagePickerUtil();

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    _userEmail = await _authService.getUserEmail();
    _userAvatarUrl = await _authService.getUserAvatarUrl();
    setState(() {});
  }

  // Функция для выбора изображения
  Future<void> _pickImage() async {
    final File? image = await _imagePicker.pickImageFromGallery();
    if (image != null) {
      await _authService.updateUserAvatar(image);
      _userAvatarUrl = await _authService.getUserAvatarUrl();
      setState(() {});
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
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _userAvatarUrl != null
                      ? NetworkImage(_userAvatarUrl!)
                      : const AssetImage('assets/person.png'),
                ),
                Positioned(
                  bottom: -16,
                  right: -16,
                  child: IconButton(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo_camera),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              _userEmail ?? 'Неизвестно',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            if (!_authService.isEmailVerified())
              ElevatedButton(
                onPressed: () async {
                  await _authService.sendEmailVerification();
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
            ElevatedButton(
              onPressed: () async {
                await _authService.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(),
              child: const Text('Выйти'),
            ),
          ],
        ),
      ),
    );
  }
}