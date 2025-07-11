import '../core/constants.dart';
import '../core/api_client.dart';
import '../models/rover_photo.dart';

class RoverService {
  final _client = ApiClient();

  Future<List<RoverPhoto>> fetchPhotos({String sol = '1000'}) async {
    final url = '$roverBaseUrl/curiosity/photos?sol=$sol&api_key=$nasaApiKey';
    final data = await _client.getJson(url);
    return (data['photos'] as List)
        .map((e) => RoverPhoto.fromJson(e))
        .toList();
  }
}
