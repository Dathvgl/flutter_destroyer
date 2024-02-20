class MangaUserFollow {
  final String id;
  final String currentChapterId;
  final String lastestChapterId;
  final int createdAt;

  const MangaUserFollow({
    required this.id,
    required this.currentChapterId,
    required this.lastestChapterId,
    required this.createdAt,
  });

  factory MangaUserFollow.fromJson(Map<String, dynamic> json) {
    return MangaUserFollow(
      id: json["_id"] as String,
      currentChapterId: json["currentChapterId"] as String,
      lastestChapterId: json["lastestChapterId"] as String,
      createdAt: json["createdAt"] as int,
    );
  }
}
