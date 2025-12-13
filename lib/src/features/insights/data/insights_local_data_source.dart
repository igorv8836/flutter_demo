import '../model/insight.dart';

class InsightsLocalDataSource {
  List<Insight> getInsights(DateTime now) {
    final isEvening = now.hour >= 17;
    final isMorning = now.hour <= 11;
    final isMonday = now.weekday == DateTime.monday;
    final isFriday = now.weekday == DateTime.friday;
    final items = <Insight>[];

    items.addAll(
      const [
        Insight(
          title: 'Чек-ин настроения',
          description: 'Отметьте уровень стресса и настрой — это займет минуту и поможет заметить тенденции.',
          severity: InsightSeverity.info,
          action: 'Откройте экран «Стресс и настроение» и обновите слайдеры',
        ),
        Insight(
          title: 'Правило трёх задач',
          description: 'Определите 3 приоритета на день и одно приятное действие для баланса.',
          severity: InsightSeverity.positive,
          action: 'Запишите приоритеты и отметьте выполнение вечером',
        ),
        Insight(
          title: 'Длинный выдох',
          description: '5 глубоких вдохов/выдохов снижают уровень кортизола и улучшают концентрацию.',
          severity: InsightSeverity.info,
          action: 'Сделайте паузу на 90 секунд прямо сейчас',
        ),
      ],
    );

    if (isMorning) {
      items.add(
        const Insight(
          title: 'Щадящий старт',
          description: 'Начните день с простого действия: стакан воды, зарядка или 5 минут планирования.',
          severity: InsightSeverity.positive,
          action: 'Отметьте выполненное и переходите к первому приоритету',
        ),
      );
    }

    if (isEvening) {
      items.add(
        const Insight(
          title: 'Завершение дня',
          description: 'Подведите итоги: что получилось, что перенести. Это снижает тревожность и освобождает голову.',
          severity: InsightSeverity.info,
          action: 'Запишите одно достижение и один вывод',
        ),
      );
    }

    if (isMonday) {
      items.add(
        const Insight(
          title: 'Фокус недели',
          description: 'Выберите один главный вектор недели: здоровье, работа или отношения.',
          severity: InsightSeverity.info,
          action: 'Сверьте план задач с выбранным фокусом',
        ),
      );
    }

    if (isFriday) {
      items.add(
        const Insight(
          title: 'Перезагрузка на выходных',
          description: 'Запланируйте активность, которая восстанавливает: прогулка, спорт, встреча с друзьями.',
          severity: InsightSeverity.positive,
          action: 'Добавьте событие в календарь прямо сейчас',
        ),
      );
    }

    return items;
  }
}
