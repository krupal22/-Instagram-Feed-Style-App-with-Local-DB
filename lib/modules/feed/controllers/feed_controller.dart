import 'package:get/get.dart';
import 'package:instagram_feed/modules/auth/controllers/auth_controller.dart';
import 'package:sqflite/sqflite.dart';
import '../../../data/db/db_helper.dart';
import '../../../data/models/post_model.dart';

class FeedController extends GetxController {
  var posts = <PostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPosts();
  }



  Future<void> loadPosts() async {

    AuthController authController=Get.find();
    final db = await DBHelper.database;
    final postMaps = await db.query('posts', orderBy: 'id DESC');



    posts.clear();

    for (var postMap in postMaps) {

      final liked = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM likes WHERE postId = ? AND username = ?',
        [postMap['id'], authController.username.value], // replace with actual logged in user
      ))! > 0;

      final commentCount = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM comments WHERE postId = ?',
        [postMap['id']],
      )) ?? 0;


      final post = PostModel.fromMap(postMap)
        ..isLiked = liked
        ..commentCount = commentCount;

      posts.add(post);
    }

    // If no posts, add dummy data
    if (posts.isEmpty) await addDummyPosts();
  }

  Future<void> addDummyPosts() async {
    final db = await DBHelper.database;
    for (int i = 1; i <= 5; i++) {
      final dummy = PostModel(
        username: 'user$i',
        imagePath: 'https://picsum.photos/seed/$i/300/200',
        caption: 'This is post $i',
        timestamp: DateTime.now().toString(),
      );
      await db.insert('posts', dummy.toMap());
    }
    await loadPosts();
  }

  Future<void> likePost(PostModel post) async {
    final db = await DBHelper.database;
    final newCount = post.likeCount + 1;
    await db.update(
      'posts',
      {'likeCount': newCount},
      where: 'id = ?',
      whereArgs: [post.id],
    );
    await loadPosts();
  }

  Future<void> toggleLike(PostModel post) async {
    AuthController authController=Get.find();
    final db = await DBHelper.database;

    final isLiked = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM likes WHERE postId = ? AND username = ?',
      [post.id, authController.username.value],
    ))! > 0;

    if (isLiked) {
      // Unlike
      await db.delete('likes',
          where: 'postId = ? AND username = ?', whereArgs: [post.id, authController.username.value]);
      await db.update('posts', {'likeCount': post.likeCount - 1},
          where: 'id = ?', whereArgs: [post.id]);

      post.isLiked =false;
      post.likeCount--;

    } else {
      // Like
      await db.insert('likes', {'postId': post.id, 'username': authController.username.value});
      await db.update('posts', {'likeCount': post.likeCount + 1},
          where: 'id = ?', whereArgs: [post.id]);
      post.isLiked =true;
      post.likeCount++;
    }


    int index = posts.indexWhere((p) => p.id == post.id);

    print("My index $index");
    print("My index ${post.isLiked}");
    if (index != -1) {
      posts[index] = post;
    }

  }

}
