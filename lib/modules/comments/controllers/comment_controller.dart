import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/db/db_helper.dart';
import '../../../data/models/comment_model.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../feed/controllers/feed_controller.dart';

class CommentController extends GetxController {
  final int postId;
  CommentController(this.postId);

  var comments = <CommentModel>[].obs;
  final commentController = TextEditingController();
  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    loadComments();
  }

  Future<void> loadComments() async {
    final db = await DBHelper.database;
    final result = await db.query(
      'comments',
      where: 'postId = ?',
      whereArgs: [postId],
      orderBy: 'id DESC',
    );
    comments.value = result.map((e) => CommentModel.fromMap(e)).toList();
  }

  Future<void> addComment() async {
    final text = commentController.text.trim();
    if (text.isEmpty) return;

    final comment = CommentModel(
      postId: postId,
      username: authController.username.value,
      text: text,
      timestamp: DateTime.now().toString(),
    );

    final db = await DBHelper.database;
    await db.insert('comments', comment.toMap());

    commentController.clear();
    await loadComments();
    Get.find<FeedController>().loadPosts();
  }
}
