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
}
