import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/download_helper.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../feed/controllers/feed_controller.dart';
import '../../../data/models/post_model.dart';
import 'fullscreen_image_screen.dart';

class FeedScreen extends StatelessWidget {
  final FeedController controller = Get.put(FeedController());
  final AuthController authController = Get.find();

  String formatDate(String date) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.parse(date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('InstaFeed', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black87),
            onPressed: () => authController.logout(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1E88E5),
        onPressed: () => Get.toNamed('/new-post')?.then((_) => controller.loadPosts()),
        child: const Icon(Icons.add,color: Colors.white,),
      ),
      body: Obx(() {
        return controller.posts.isEmpty
            ? const Center(child: Text("No posts yet", style: TextStyle(fontSize: 16)))
            : ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            final post = controller.posts[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    title: Text(post.username,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(formatDate(post.timestamp),
                        style: const TextStyle(fontSize: 12)),
                  ),

                  // Image
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => FullscreenImageScreen(imagePath: post.imagePath));
                        },
                        child: Hero(
                          tag: post.imagePath,
                          child: Uri.parse(post.imagePath).isAbsolute
                              ? Image.network(post.imagePath)
                              : Image.file(File(post.imagePath)),
                        ),
                      ),
                    ),
                  ),

                  // Caption
                  if (post.caption.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Text(post.caption,
                          style: const TextStyle(fontSize: 14, color: Colors.black87)),
                    ),

                  // Action Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                post.isLiked ? Icons.favorite : Icons.favorite_border,
                                color: post.isLiked ? Colors.red : Colors.grey[600],
                              ),
                              onPressed: () => controller.toggleLike(post),
                            ),
                            Text("${post.likeCount}"),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.comment),
                              onPressed: () {
                                Get.toNamed('/comments', arguments: post.id);
                              },
                            ),
                            Text("${post.commentCount}"),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.download, color: Colors.grey),
                              onPressed: () async {
                                await DownloadHelper.downloadAndSaveImage(
                                    post.imagePath, context);
                                Get.snackbar("Downloaded", "Image saved to gallery");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

