class PasswordLocalDataSource {
  String _storedPin = '1234';

  String readPin() => _storedPin;

  void writePin(String pin) {
    _storedPin = pin;
  }
}
