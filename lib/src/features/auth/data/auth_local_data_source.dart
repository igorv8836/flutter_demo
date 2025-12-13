import '../model/auth_user.dart';

class AuthLocalDataSource {
  final List<AuthUser> _users = [
    const AuthUser(email: 'demo@sleep.app', name: 'Demo User', password: 'demo123'),
  ];
  String? _currentEmail;

  AuthUser? readCurrent() {
    if (_currentEmail == null) return null;
    return _users.where((u) => u.email == _currentEmail).firstOrNull;
  }

  List<AuthUser> readUsers() => List.unmodifiable(_users);

  AuthUser? findByEmail(String email) => _users.where((u) => u.email == email).firstOrNull;

  void saveUser(AuthUser user) {
    final index = _users.indexWhere((u) => u.email == user.email);
    if (index == -1) {
      _users.add(user);
    } else {
      _users[index] = user;
    }
  }

  void setCurrent(AuthUser? user) {
    _currentEmail = user?.email;
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull {
    if (isEmpty) return null;
    return first;
  }
}
