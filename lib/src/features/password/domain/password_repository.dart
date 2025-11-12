import '../data/password_local_data_source.dart';

class PasswordRepository {
  var version = 0;
  final PasswordLocalDataSource _local;

  PasswordRepository(this._local);

  bool verifyPin(String pin) => _local.readPin() == pin;

  void updatePin(String pin) {
    _local.writePin(pin);
    version = version + 1;
  }
}
