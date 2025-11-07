import 'awakening.dart';

enum SleepQuality { poor, fair, good, great }

class SleepSession {
  final String id;
  final DateTime start;
  final DateTime? end;
  final List<Awakening> awakenings;
  final SleepQuality? quality;
  final String? note;
  const SleepSession({
    required this.id,
    required this.start,
    this.end,
    this.awakenings = const [],
    this.quality,
    this.note,
  });
  SleepSession copyWith({
    String? id,
    DateTime? start,
    DateTime? end,
    List<Awakening>? awakenings,
    SleepQuality? quality,
    String? note,
  }) {
    return SleepSession(
      id: id ?? this.id,
      start: start ?? this.start,
      end: end ?? this.end,
      awakenings: awakenings ?? this.awakenings,
      quality: quality ?? this.quality,
      note: note ?? this.note,
    );
  }
  Duration get inBed => end == null ? Duration.zero : end!.difference(start).isNegative ? Duration.zero : end!.difference(start);
  Duration get awakeningsDuration => awakenings.fold(Duration.zero, (a, b) => a + b.duration);
  Duration get asleep => inBed - awakeningsDuration <= Duration.zero ? Duration.zero : inBed - awakeningsDuration;
}
