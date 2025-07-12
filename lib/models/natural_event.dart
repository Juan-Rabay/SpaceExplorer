class NaturalEvent {
  final String title;
  final String category;
  final String date;

  NaturalEvent({
    required this.title,
    required this.category,
    required this.date,
  });

  factory NaturalEvent.fromJson(Map<String, dynamic> json) {
    return NaturalEvent(
      title: json['messageBody'] ?? 'Sin título',
      category: json['messageType'] ?? 'Sin categoría',
      date: json['messageIssueTime'] ?? '',
    );
  }
}