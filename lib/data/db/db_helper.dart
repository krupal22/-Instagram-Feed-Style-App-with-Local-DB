import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'insta_feed.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE posts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            imagePath TEXT,
            caption TEXT,
            timestamp TEXT,
            likeCount INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE comments (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            postId INTEGER,
            username TEXT,
            comment TEXT,
            timestamp TEXT
          )
        ''');

        await db.execute('''
  CREATE TABLE likes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    postId INTEGER,
    username TEXT
  )
''');


      },
    );
  }
}
