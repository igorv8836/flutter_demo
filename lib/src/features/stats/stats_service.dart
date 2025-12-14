import '../settings/core/model/settings.dart';
import '../sleep/core/model/sleep_session.dart';

class Stats {
  final Duration avgDuration;
  final double efficiency;
  final Duration regularity;
  final int sleepScore;
  const Stats({required this.avgDuration, required this.efficiency, required this.regularity, required this.sleepScore});
}

class StatsService {
  Stats compute(List<SleepSession> sessions, Settings settings, {int days = 7}) {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    final recent = sessions.where((s) => s.end != null && s.end!.isAfter(cutoff)).toList();
    if (recent.isEmpty) {
      return Stats(avgDuration: Duration.zero, efficiency: 0, regularity: Duration.zero, sleepScore: 0);
    }
    final avgDur = recent.map((s) => s.asleep).fold(Duration.zero, (a, b) => a + b) ~/ recent.length;
    final effs = recent.map((s) => s.inBed.inMinutes == 0 ? 0.0 : s.asleep.inMinutes / s.inBed.inMinutes).toList();
    final eff = effs.reduce((a, b) => a + b) / effs.length;
    final bedtimes = recent.map((s) => DateTime(s.start.year, s.start.month, s.start.day, s.start.hour, s.start.minute)).toList();
    final meanMinutes = bedtimes.map((d) => d.hour * 60 + d.minute).reduce((a, b) => a + b) / bedtimes.length;
    final variance = bedtimes.map((d) {
      final m = d.hour * 60 + d.minute;
      final diff = m - meanMinutes;
      return diff * diff;
    }).reduce((a, b) => a + b) / bedtimes.length;
    final stdevMin = variance == 0 ? 0.0 : MathHelper.sqrt(variance);
    final reg = Duration(minutes: stdevMin.round());
    final dNorm = _clamp(avgDur.inMinutes / settings.targetDuration.inMinutes.toDouble());
    final eNorm = _clamp(eff);
    final rNorm = 1.0 - _clamp(reg.inMinutes / 120.0);
    final score = ((dNorm * 0.45 + eNorm * 0.35 + rNorm * 0.20) * 100).round();
    return Stats(avgDuration: avgDur, efficiency: eff, regularity: reg, sleepScore: score);
  }
}

double _clamp(double v) => v < 0 ? 0 : (v > 1 ? 1 : v);

class MathHelper {
  static double sqrt(double x) {
    double r = x <= 0 ? 0 : x;
    double g = x <= 0 ? 0 : x / 2;
    for (int i = 0; i < 20; i++) {
      if (g == 0) break;
      g = 0.5 * (g + r / g);
    }
    return g.isNaN ? 0 : g;
  }
}
