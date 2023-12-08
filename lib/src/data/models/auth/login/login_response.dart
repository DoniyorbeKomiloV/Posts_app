class UserResponse {
  final String name;
  final String password;
  final String id;
  final String login;

  UserResponse({
    required this.name,
    required this.password,
    required this.id,
    required this.login,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      name: json['name'] as String,
      password: json['password'] as String,
      id: json['id'] as String,
      login: json['login'] as String,
    );
  }
}
