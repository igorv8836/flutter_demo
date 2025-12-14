import '../core/model/auth_user.dart';

abstract class AuthDataSource {
  AuthUser? readCurrent();
  List<AuthUser> readUsers();
  AuthUser? findByEmail(String email);
  void saveUser(AuthUser user);
  void setCurrent(AuthUser? user);
}
