import 'password_data_source.dart';

class PasswordLocalDataSource implements PasswordDataSource {
  String _storedPin = '1234';

  @override
  String readPin() => _storedPin;

  @override
  void writePin(String pin) {
    _storedPin = pin;
  }
}
