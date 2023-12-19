class User {
  final int id;
  final String name;
  final String username;
  final String profilePhoto;
  final String email;
  final String? emailVerifiedAt;  // null olabileceği için nullable
  final String? phone;
  final String? bio;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.profilePhoto,
    required this.email,
    this.emailVerifiedAt,
    required this.phone,
    required this.bio,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      profilePhoto: json['profile_photo'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      phone: json['phone'],
      bio: json['bio'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'profile_photo': profilePhoto,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'phone': phone,
      'bio': bio,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class AuthResponse {
  final User user;
  final String token;

  AuthResponse({
    required this.user,
    required this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }

  // Eğer AuthResponse'u da JSON'a dönüştürmek isterseniz bu metodu ekle.
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token': token,
    };
  }
}
