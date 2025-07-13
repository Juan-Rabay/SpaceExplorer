import '../core/constants.dart';
import '../core/api_client.dart';
import '../models/natural_event.dart';

class EonetService {
  final _client = ApiClient();

  Future<List<NaturalEvent>> fetchEvents({
    String status = 'open',
    String? category,
    int days = 20,
    int limit = 50,
  }) async {
    final queryParams = {
      'status': status,
      'days': days.toString(),
      'limit': limit.toString(),
      if (category != null) 'category': category,
    };

    final uri = Uri.https('eonet.gsfc.nasa.gov', '/api/v2.1/events', queryParams);
    final data = await _client.getJson(uri.toString());

    final list = data['events'] as List<dynamic>;
    return list.map((e) => NaturalEvent.fromJson(e)).toList();
  }
}
