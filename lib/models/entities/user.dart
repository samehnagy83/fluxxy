
class User {
  String id;
  String name;
  String email;
  String? token;
  String? avatar;
  String? role;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.token,
    this.avatar,
    this.role,
  });

  bool get isLoggedIn => token != null && token!.isNotEmpty;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      token: json['token'] as String?,
      avatar: json['avatar'] as String?,
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'token': token,
        'avatar': avatar,
        'role': role,
      };

   User copyWith({
    String? id,
    String? name,
    String? email,
    String? token,
    String? avatar,
    String? role,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
    );
  }
}
