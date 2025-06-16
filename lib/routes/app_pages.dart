import 'package:get/get.dart';
import '../modules/auth/views/login_screen.dart';
import '../modules/comments/views/comment_screen.dart';
import '../modules/feed/views/feed_screen.dart';
import '../modules/post/views/new_post_screen.dart';


class AppPages {
  static final routes = [
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/feed', page: () => FeedScreen()),
    GetPage(name: '/new-post', page: () => NewPostScreen()),
    GetPage(
      name: '/comments',
      page: () => CommentScreen(postId: Get.arguments),
    ),


  ];
}
