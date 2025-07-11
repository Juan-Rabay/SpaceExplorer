class MediaItem {
  final String title;
  final String description;
  final String imageUrl;

  MediaItem({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    final data = json['data'][0];
    final links = json['links'];
    final imageUrl = links != null && links[0]['href'] != null
        ? links[0]['href']
        : 'https://via.placeholder.com/150';

    return MediaItem(
      title: data['title'] ?? 'Sin título',
      description: data['description'] ?? 'Sin descripción',
      imageUrl: imageUrl,
    );
  }
}
