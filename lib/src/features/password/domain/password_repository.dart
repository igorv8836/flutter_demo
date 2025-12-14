import '../data/password_data_source.dart';
import '../data/password_local_data_source.dart';

class PasswordRepository {
  var version = 0;
  final PasswordDataSource _local;

  PasswordRepository({PasswordDataSource? dataSource}) : _local = dataSource ?? PasswordLocalDataSource();

  bool verifyPin(String pin) => _local.readPin() == pin;

  void updatePin(String pin) {
    _local.writePin(pin);
    version = version + 1;
  }
}
