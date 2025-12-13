class ProfileTileData {
  final String title;
  final String subtitle;
  final String icon;

  const ProfileTileData({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class ProfileShortcutData {
  final String label;
  final String route;
  final String icon;

  const ProfileShortcutData({
    required this.label,
    required this.route,
    required this.icon,
  });
}

class ProfileData {
  final String name;
  final String email;
  final bool isAuthenticated;
  final List<ProfileTileData> focus;
  final List<ProfileShortcutData> shortcuts;

  const ProfileData({
    required this.name,
    required this.email,
    required this.isAuthenticated,
    required this.focus,
    required this.shortcuts,
  });
}
