import '../core/model/auth_user.dart';
import 'auth_data_source.dart';

class AuthLocalDataSource implements AuthDataSource {
  final List<AuthUser> _users = [
    const AuthUser(email: 'demo@sleep.app', name: 'Demo User', password: 'demo123'),
  ];
  String? _currentEmail;

  @override
  AuthUser? readCurrent() {
    if (_currentEmail == null) return null;
    return _users.where((u) => u.email == _currentEmail).firstOrNull;
  }

  @override
  List<AuthUser> readUsers() => List.unmodifiable(_users);

  @override
  AuthUser? findByEmail(String email) => _users.where((u) => u.email == email).firstOrNull;

  @override
  void saveUser(AuthUser user) {
    final index = _users.indexWhere((u) => u.email == user.email);
    if (index == -1) {
      _users.add(user);
    } else {
      _users[index] = user;
    }
  }

  @override
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
