import '../core/constants.dart';
import '../core/api_client.dart';
import '../models/natural_event.dart';

class EonetService {
  final _client = ApiClient();

  Future<List<NaturalEvent>> fetchEvents({
    String type = 'all',
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final start = startDate?.toUtc().toIso8601String().split('T').first;
    final end = endDate?.toUtc().toIso8601String().split('T').first;

    final queryParams = {
      'type': type,
      if (start != null) 'startDate': start,
      if (end != null) 'endDate': end,
      'api_key': nasaApiKey
    };

    final uri = Uri.https('api.nasa.gov', '/DONKI/notifications', queryParams);
    final data = await _client.getJson(uri.toString());

    final list = data as List<dynamic>;
    return list.map((e) => NaturalEvent.fromJson(e)).toList();
  }
}