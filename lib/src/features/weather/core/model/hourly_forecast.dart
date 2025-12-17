class ForecastPoint {
  final DateTime time;
  final double temperature;
  final double precipitation;
  final int cloudCover;

  const ForecastPoint({
    required this.time,
    required this.temperature,
    required this.precipitation,
    required this.cloudCover,
  });
}

class HourlyForecast {
  final List<ForecastPoint> points;
  const HourlyForecast({this.points = const []});

  ForecastPoint? get next => points.isEmpty ? null : points.first;
}
