import '../domain/profile_data.dart';

abstract class ProfileDataSource {
  List<ProfileTileData> focus();
  List<ProfileShortcutData> shortcuts();
}
