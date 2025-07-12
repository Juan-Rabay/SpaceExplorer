import '../core/constants.dart';
import '../core/api_client.dart';
import '../models/rover_photo.dart';

class RoverService {
  final _client = ApiClient();

  Future<List<RoverPhoto>> fetchPhotos({String rover = 'curiosity', DateTime? earthDate}) async {
    final dateParam = earthDate != null
        ? '&earth_date=${earthDate.toIso8601String().split('T')[0]}'
        : '&sol=1000';

    final url = 'https://api.nasa.gov/mars-photos/api/v1/rovers/$rover/photos?$dateParam&api_key=$nasaApiKey';

    final data = await _client.getJson(url);
    return (data['photos'] as List)
        .map((json) => RoverPhoto.fromJson(json))
        .toList();
  }
}
