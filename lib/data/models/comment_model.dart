class CommentModel {
  final int? id;
  final int postId;
  final String username;
  final String text;
  final String timestamp;

  CommentModel({
    this.id,
    required this.postId,
    required this.username,
    required this.text,
    required this.timestamp,
  });

  factory CommentModel.fromMap(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      postId: json['postId'],
      username: json['username'],
      text: json['comment'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'postId': postId,
      'username': username,
      'comment': text,
      'timestamp': timestamp,
    };
  }
}
