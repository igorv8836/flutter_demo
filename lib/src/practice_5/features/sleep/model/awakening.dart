class Awakening {
  final DateTime start;
  final DateTime? end;
  const Awakening({required this.start, this.end});
  Awakening copyWith({DateTime? start, DateTime? end}) => Awakening(start: start ?? this.start, end: end ?? this.end);
  Duration get duration => end == null ? Duration.zero : end!.difference(start).isNegative ? Duration.zero : end!.difference(start);
}