import 'profile_data.dart';

abstract class ProfileRepository {
  List<ProfileTileData> focus();
  List<ProfileShortcutData> shortcuts();
}
