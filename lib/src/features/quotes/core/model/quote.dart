class Quote {
  final String id;
  final String content;
  final String author;
  final List<String> tags;

  const Quote({
    required this.id,
    required this.content,
    required this.author,
    this.tags = const [],
  });
}
