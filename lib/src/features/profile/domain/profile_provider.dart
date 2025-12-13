import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/domain/auth_controller.dart';
import '../data/profile_local_data_source.dart';
import 'profile_data.dart';

final profileDataSourceProvider = Provider((ref) => const ProfileLocalDataSource());

final profileProvider = Provider<ProfileData>((ref) {
  final auth = ref.watch(authControllerProvider);
  final user = auth.user;
  final source = ref.watch(profileDataSourceProvider);

  return ProfileData(
    name: user?.name.isNotEmpty == true ? user!.name : 'Без имени',
    email: user?.email ?? 'email не указан',
    isAuthenticated: auth.isAuthenticated,
    focus: source.focus(),
    shortcuts: source.shortcuts(),
  );
});
