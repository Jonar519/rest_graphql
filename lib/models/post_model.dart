class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  String get avatarUrl {
    final styles = ['set1', 'set2', 'set3', 'set4'];
    final style = styles[userId % styles.length];
    return 'https://robohash.org/user_$userId?set=$style&size=200x200';
  }
}
