import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/media_item.dart';
import '../core/constants.dart';

class MediaService {
  Future<List<MediaItem>> searchMedia(String query) async {
    final url = '$mediaSearchUrl?q=$query&media_type=image';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['collection']['items'] as List;
      return items.map((e) => MediaItem.fromJson(e)).toList();
    } else {
      throw Exception('Error al buscar imágenes');
    }
  }
}
