import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/profile_data.dart';
import '../domain/profile_repository.dart';
import 'profile_data_source.dart';
import 'profile_local_data_source.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl();
});

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({ProfileDataSource? dataSource}) : _local = dataSource ?? const ProfileLocalDataSource();

  final ProfileDataSource _local;

  @override
  List<ProfileShortcutData> shortcuts() => _local.shortcuts();

  @override
  List<ProfileTileData> focus() => _local.focus();
}
