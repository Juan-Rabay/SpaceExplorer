import '../core/constants.dart';
import '../core/api_client.dart';
import '../models/natural_event.dart';

class EonetService {
  final _client = ApiClient();

  Future<List<NaturalEvent>> fetchEvents() async {
    final data = await _client.getJson(eonetUrl);
    return (data['events'] as List)
        .map((e) => NaturalEvent.fromJson(e))
        .toList();
  }
}
