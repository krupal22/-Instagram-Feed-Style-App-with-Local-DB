class PostModel {
  final int? id;
  final String username;
  final String imagePath;
  final String caption;
  final String timestamp;
   int likeCount;
  bool isLiked;
  int commentCount;

  PostModel({
    this.id,
    required this.username,
    required this.imagePath,
    required this.caption,
    required this.timestamp,
    this.likeCount = 0,
    this.isLiked = false,
    this.commentCount = 0
  });

  factory PostModel.fromMap(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      username: json['username'],
      imagePath: json['imagePath'],
      caption: json['caption'],
      timestamp: json['timestamp'],
      likeCount: json['likeCount'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'imagePath': imagePath,
      'caption': caption,
      'timestamp': timestamp,
      'likeCount': likeCount,
    };
  }
}
