class WellbeingState {
  final double stress; // 0..1
  final double mood; // 0..1
  final int waterMl;
  final String? lastNote;
  final String? activeAction;
  final DateTime? actionEndsAt;

  const WellbeingState({
    this.stress = 0.45,
    this.mood = 0.65,
    this.waterMl = 0,
    this.lastNote,
    this.activeAction,
    this.actionEndsAt,
  });

  WellbeingState copyWith({
    double? stress,
    double? mood,
    int? waterMl,
    String? lastNote,
    String? activeAction,
    DateTime? actionEndsAt,
  }) {
    return WellbeingState(
      stress: stress ?? this.stress,
      mood: mood ?? this.mood,
      waterMl: waterMl ?? this.waterMl,
      lastNote: lastNote ?? this.lastNote,
      activeAction: activeAction ?? this.activeAction,
      actionEndsAt: actionEndsAt ?? this.actionEndsAt,
    );
  }
}
