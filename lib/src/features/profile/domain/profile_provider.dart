import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/presentation/auth_controller.dart';
import '../data/profile_repository_impl.dart';
import 'profile_data.dart';

final profileProvider = Provider<ProfileData>((ref) {
  final auth = ref.watch(authControllerProvider);
  final user = auth.user;
  final repo = ref.watch(profileRepositoryProvider);

  return ProfileData(
    name: user?.name.isNotEmpty == true ? user!.name : 'Без имени',
    email: user?.email ?? 'email не указан',
    isAuthenticated: auth.isAuthenticated,
    focus: repo.focus(),
    shortcuts: repo.shortcuts(),
  );
});
