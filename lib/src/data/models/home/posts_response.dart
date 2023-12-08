
class PostsResponse {
  final String title;
  final String creatorId;
  final String body;
  final String id;
  final String name;

  PostsResponse({
    required this.title,
    required this.creatorId,
    required this.body,
    required this.id,
    required this.name,
  });

  factory PostsResponse.fromJson(Map<String, dynamic> json) {
    return PostsResponse(
      title: json['title'] as String,
      creatorId: json['creatorId'] as String,
      body: json['body'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}
