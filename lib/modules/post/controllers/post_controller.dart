import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/db/db_helper.dart';
import '../../../data/models/post_model.dart';
import '../../auth/controllers/auth_controller.dart';

class PostController extends GetxController {
  final captionController = TextEditingController();
  File? selectedImage;
  final authController = Get.find<AuthController>();

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      update();
    }
  }

  Future<void> savePost() async {
    if (selectedImage == null) return;

    final post = PostModel(
      username: authController.username.value,
      imagePath: selectedImage!.path,
      caption: captionController.text.trim(),
      timestamp: DateTime.now().toString(),
    );

    final db = await DBHelper.database;
    await db.insert('posts', post.toMap());

    captionController.clear();
    selectedImage = null;
    update();

    Get.back(); // Go back to feed
  }
}
