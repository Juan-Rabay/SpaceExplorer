// lib/models/natural_event.dart

class NaturalEvent {
  final String id;
  final String title;
  final String description;
  final String category;
  final String date;
  final double? latitude;
  final double? longitude;

  NaturalEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    this.latitude,
    this.longitude,
  });

  factory NaturalEvent.fromJson(Map<String, dynamic> json) {
    final coords = json['geometry']?[0]?['coordinates'];
    double? lon, lat;
    if (coords != null && coords is List && coords.length >= 2) {
      lon = (coords[0] as num).toDouble();
      lat = (coords[1] as num).toDouble();
    }
    return NaturalEvent(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] ?? 'Sin descripción',
      category: json['categories']?[0]?['title'] ?? 'General',
      date: json['geometry']?[0]?['date'] ?? '',
      latitude: lat,
      longitude: lon,
    );
  }
}
