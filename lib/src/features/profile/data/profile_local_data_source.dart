import '../domain/profile_data.dart';
import 'profile_data_source.dart';

class ProfileLocalDataSource implements ProfileDataSource {
  const ProfileLocalDataSource();

  @override
  List<ProfileTileData> focus() => const [
        ProfileTileData(
          title: 'Бережное отношение к себе',
          subtitle: 'Запланируйте небольшую награду за завершённые дела.',
          icon: 'heart',
        ),
        ProfileTileData(
          title: 'Личные границы',
          subtitle: 'Оставьте в расписании хотя бы 30 минут без задач.',
          icon: 'shield',
        ),
        ProfileTileData(
          title: 'Поддержка',
          subtitle: 'Напомните себе, кто может помочь, если день перегружен.',
          icon: 'support',
        ),
      ];

  @override
  List<ProfileShortcutData> shortcuts() => const [
        ProfileShortcutData(label: 'Настройки', route: '/settings', icon: 'settings'),
        ProfileShortcutData(label: 'Рекомендации', route: '/insights', icon: 'light'),
        ProfileShortcutData(label: 'Стресс и настроение', route: '/wellbeing', icon: 'mood'),
      ];
}
