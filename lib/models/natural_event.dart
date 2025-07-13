class NaturalEvent {
  final String id;
  final String title;
  final String? description;
  final String category;
  final String source;
  final String? link;
  final String date;
  final double? latitude;
  final double? longitude;

  NaturalEvent({
    required this.id,
    required this.title,
    required this.category,
    required this.source,
    required this.date,
    this.description,
    this.link,
    this.latitude,
    this.longitude,
  });

  factory NaturalEvent.fromJson(Map<String, dynamic> json) {
    final geometry = (json['geometries'] as List?)?.first;
    final coordinates = geometry?['coordinates'] as List?;

    return NaturalEvent(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      link: json['link'],
      category: (json['categories'] as List).isNotEmpty
          ? json['categories'][0]['title']
          : 'Sin categoría',
      source: (json['sources'] as List).isNotEmpty
          ? json['sources'][0]['id']
          : 'Desconocido',
      date: geometry?['date'] ?? 'Sin fecha',
      latitude: coordinates != null ? (coordinates[1] as num?)?.toDouble() : null,
      longitude: coordinates != null ? (coordinates[0] as num?)?.toDouble() : null,
    );
  }
}