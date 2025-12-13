enum InsightSeverity { positive, warning, info }

class Insight {
  final String title;
  final String description;
  final InsightSeverity severity;
  final String action;

  const Insight({
    required this.title,
    required this.description,
    required this.severity,
    required this.action,
  });
}
