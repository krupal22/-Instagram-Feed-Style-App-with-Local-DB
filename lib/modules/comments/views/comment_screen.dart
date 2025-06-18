
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/comment_controller.dart';

class CommentScreen extends StatelessWidget {
  final int postId;

  CommentScreen({required this.postId});

  String formatDate(String date) {
    return DateFormat('dd MMM, hh:mm a').format(DateTime.parse(date));
  }

  @override
  Widget build(BuildContext context) {
    final CommentController controller = Get.put(CommentController(postId));

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          title: const Text(
            "Comments",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 1,
        ),
        body: Column(
          children: [
            // Comment list
            Expanded(
              child: Obx(() {
                return controller.comments.isEmpty
                    ? const Center(child: Text("No comments yet"))
                    : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: controller.comments.length,
                  itemBuilder: (context, index) {
                    final c = controller.comments[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c.username,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            c.text,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            formatDate(c.timestamp),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),

            // Comment input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: const Border(top: BorderSide(color: Colors.grey, width: 0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, -1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.commentController,
                      decoration: InputDecoration(
                        hintText: "Write a comment...",
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: controller.addComment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E88E5),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Post",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
