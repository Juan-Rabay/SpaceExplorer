import 'package:flutter/material.dart';
import '../core/eonet_service.dart';
import '../models/natural_event.dart';
import '../core/connectivity_service.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({Key? key}) : super(key: key);

  @override
  State<EventListScreen> createState() => EventListScreenState();
}

class EventListScreenState extends State<EventListScreen> {
  late Future<List<NaturalEvent>> _futureEvents;
  bool _loading = true;
  bool _offline = false;
  String? _error;
  final _conn = ConnectivityService();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final online = await _conn.isOnline;
    if (!online) {
      setState(() {
        _offline = true;
        _loading = false;
      });
    } else {
      _futureEvents = EonetService().fetchEvents();
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Eventos Naturales')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_offline) {
      return Scaffold(
        appBar: AppBar(title: const Text('Eventos Naturales Offline')),
        body: const Center(child: Text('Sin conexión a internet')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Eventos Naturales')),
      body: FutureBuilder<List<NaturalEvent>>(
        future: _futureEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron eventos.'));
          }

          final events = snapshot.data!;
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (_, i) {
              final e = events[i];
              return ListTile(
                leading: const Icon(Icons.warning_amber),
                title: Text(e.title),
                subtitle: Text('${e.category} • ${e.date.split("T")[0]}'),
              );
            },
          );
        },
      ),
    );
  }
}
