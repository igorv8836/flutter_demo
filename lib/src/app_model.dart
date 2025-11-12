import 'features/settings/model/settings.dart';
import 'features/sleep/model/sleep_session.dart';

class AppModel {
  Settings settings = const Settings();
  final List<SleepSession> sessions = [];
}

class MyClass {
  const MyClass({
    required String arg1,
    required String arg2,
    required String arg3,
    required String arg4,
    required String arg5,
    required String arg6,
    required String arg7,
    required String arg8,
  });
}

void main(List<String> args) {
  // ignore: unused_local_variable
  const obj = MyClass(
      arg1: 'arg1',
      arg2: 'arg2',
      arg3: 'arg3',
      arg4: 'arg4',
      arg5: 'arg5',
      arg6: 'arg6',
      arg7: 'arg7',
      arg8: 'arg8'
  );
}
