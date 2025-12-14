class AuthUser {
  final String email;
  final String name;
  final String password;

  const AuthUser({
    required this.email,
    required this.name,
    required this.password,
  });

  AuthUser copyWith({
    String? email,
    String? name,
    String? password,
  }) {
    return AuthUser(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
    );
  }

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
        email: json['email'] as String? ?? '',
        name: json['name'] as String? ?? '',
        password: json['password'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'password': password,
      };
}
