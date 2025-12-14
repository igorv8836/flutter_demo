import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../core/model/auth_user.dart';
import 'auth_data_source.dart';

class AuthLocalDataSource implements AuthDataSource {
  AuthLocalDataSource._(this._storage, this._users, this._currentEmail);

  final FlutterSecureStorage _storage;
  final List<AuthUser> _users;
  String? _currentEmail;

  static const _usersKey = 'auth_users';
  static const _currentKey = 'auth_current';
  static const _demoUser = AuthUser(email: 'demo@sleep.app', name: 'Demo User', password: 'demo123');

  static Future<AuthLocalDataSource> create(FlutterSecureStorage storage) async {
    final users = await _readUsers(storage) ?? [_demoUser];
    final currentEmail = await storage.read(key: _currentKey);
    return AuthLocalDataSource._(storage, users, currentEmail);
  }

  static Future<List<AuthUser>?> _readUsers(FlutterSecureStorage storage) async {
    final raw = await storage.read(key: _usersKey);
    if (raw == null) return null;
    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded.map((e) => AuthUser.fromJson(Map<String, dynamic>.from(e as Map))).toList();
    } catch (_) {
      return null;
    }
  }

  @override
  AuthUser? readCurrent() {
    if (_currentEmail == null) return null;
    return _firstOrNull((u) => u.email == _currentEmail);
  }

  @override
  List<AuthUser> readUsers() => List.unmodifiable(_users);

  @override
  AuthUser? findByEmail(String email) => _firstOrNull((u) => u.email == email);

  @override
  void saveUser(AuthUser user) {
    final index = _users.indexWhere((u) => u.email == user.email);
    if (index == -1) {
      _users.add(user);
    } else {
      _users[index] = user;
    }
    _persistUsers();
  }

  AuthUser? _firstOrNull(bool Function(AuthUser user) test) {
    for (final user in _users) {
      if (test(user)) return user;
    }
    return null;
  }

  @override
  void setCurrent(AuthUser? user) {
    _currentEmail = user?.email;
    _persistCurrent();
  }

  void _persistUsers() {
    final json = jsonEncode(_users.map((u) => u.toJson()).toList());
    unawaited(_storage.write(key: _usersKey, value: json));
  }

  void _persistCurrent() {
    if (_currentEmail == null) {
      unawaited(_storage.delete(key: _currentKey));
    } else {
      unawaited(_storage.write(key: _currentKey, value: _currentEmail));
    }
  }
}
