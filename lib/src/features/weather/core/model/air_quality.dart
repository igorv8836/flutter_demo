class AirQuality {
  final DateTime time;
  final double pm25;
  final double pm10;
  final int? usAqi;

  const AirQuality({
    required this.time,
    required this.pm25,
    required this.pm10,
    this.usAqi,
  });

  String get advice {
    final aqi = usAqi ?? _toAqi(pm25, pm10);
    if (aqi >= 151) return 'Высокое загрязнение — лучше сократить время на улице';
    if (aqi >= 101) return 'Воздух средний — проветрить, снизить нагрузки';
    if (aqi >= 51) return 'Хорошо, следите за самочувствием';
    return 'Чистый воздух — прогулка самое то';
  }

  int _toAqi(double pm25, double pm10) {
    // Простая приблизительная оценка AQI по PM значениям
    final pm25Scaled = (pm25 * 4).clamp(0, 200).toInt();
    final pm10Scaled = (pm10 * 2).clamp(0, 200).toInt();
    return (pm25Scaled + pm10Scaled) ~/ 2;
  }
}
