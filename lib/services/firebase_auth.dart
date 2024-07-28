import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Получение текущего пользователя
  User? get currentUser => _auth.currentUser;

  // Регистрация с помощью электронной почты и пароля
  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      // Создаем нового пользователя
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Отправляем запрос на подтверждение почты
      await sendEmailVerification();
    } catch (e) {
      rethrow; // Перебросить исключение
    }
  }

  // Вход с помощью электронной почты и пароля
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow; // Перебросить исключение
    }
  }

  // Выход из системы
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      // Удалили _googleSignIn.signOut(), так как он больше не нужен
    } catch (e) {
      rethrow; // Перебросить исключение
    }
  }

  // Отправка запроса на подтверждение почты
  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      print("Ошибка: $e");
    }
  }

  // Получение email пользователя
  Future<String?> getUserEmail() async {
    final user = _auth.currentUser;
    if (user != null) {
      return user.email;
    }
    return null;
  }

  // Получение URL аватара пользователя
  Future<String?> getUserAvatarUrl() async {
    final user = _auth.currentUser;
    if (user != null) {
      // Добавьте логику для получения URL аватара из Firebase
      // Например, вы можете использовать user.photoURL, если вы сохраняете аватар в Firebase
      return user.photoURL; 
    }
    return null;
  }

  // Проверка подтверждения почты
  bool isEmailVerified() {
    final user = _auth.currentUser;
    if (user != null) {
      return user.emailVerified;
    }
    return false;
  }

    // Получение ID пользователя
  Future<String?> getUserId() async {
    final user = _auth.currentUser;
    if (user != null) {
      return user.uid; // Возвращаем UID пользователя
    }
    return null;
  }


}
