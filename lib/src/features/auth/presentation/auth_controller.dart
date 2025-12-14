import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/auth_local_data_source.dart';
import '../data/auth_data_source.dart';
import '../core/model/auth_user.dart';

part 'auth_controller.g.dart';

class AuthState {
  final AuthUser? user;
  final List<AuthUser> knownUsers;
  final String? error;
  final bool isLoading;

  const AuthState({
    required this.user,
    required this.knownUsers,
    this.error,
    this.isLoading = false,
  });

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    AuthUser? user,
    List<AuthUser>? knownUsers,
    String? error,
    bool? isLoading,
  }) {
    return AuthState(
      user: user ?? this.user,
      knownUsers: knownUsers ?? this.knownUsers,
      error: error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  late final AuthDataSource _local;

  @override
  AuthState build() {
    _local = AuthLocalDataSource();
    final current = _local.readCurrent();
    return AuthState(
      user: current,
      knownUsers: _local.readUsers(),
      isLoading: false,
      error: null,
    );
  }

  void login(String email, String password) {
    final trimmedEmail = email.trim().toLowerCase();
    state = state.copyWith(isLoading: true, error: null);
    final user = _local.findByEmail(trimmedEmail);
    if (user == null || user.password != password) {
      state = state.copyWith(isLoading: false, error: 'Неверный логин или пароль');
      return;
    }
    _local.setCurrent(user);
    state = state.copyWith(user: user, knownUsers: _local.readUsers(), isLoading: false, error: null);
  }

  void register({required String email, required String name, required String password}) {
    final trimmedEmail = email.trim().toLowerCase();
    if (trimmedEmail.isEmpty || name.trim().isEmpty || password.length < 4) {
      state = state.copyWith(error: 'Введите email, имя и пароль не короче 4 символов');
      return;
    }
    final exists = _local.findByEmail(trimmedEmail) != null;
    if (exists) {
      state = state.copyWith(error: 'Такой пользователь уже есть');
      return;
    }
    final user = AuthUser(email: trimmedEmail, name: name.trim(), password: password);
    _local
      ..saveUser(user)
      ..setCurrent(user);
    state = state.copyWith(user: user, knownUsers: _local.readUsers(), error: null, isLoading: false);
  }

  void logout() {
    _local.setCurrent(null);
    state = state.copyWith(user: null, error: null, isLoading: false);
  }

  void clearError() {
    if (state.error != null) state = state.copyWith(error: null);
  }
}
