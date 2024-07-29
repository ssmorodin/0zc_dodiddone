// Импортируем ImagePickerUtil
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerUtil {
  final ImagePicker _picker = ImagePicker();

  // Выбираем изображение из галереи
  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      print('Ошибка при выборе изображения из галереи: $e');
    }
    return null;
  }

  // Выбираем изображение с камеры
  Future<File?> pickImageFromCamera() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      print('Ошибка при выборе изображения с камеры: $e');
    }
    return null;
  }
}
