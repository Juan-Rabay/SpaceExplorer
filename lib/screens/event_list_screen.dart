import 'package:flutter/material.dart';
import '../core/eonet_service.dart';
import '../models/natural_event.dart';
import 'event_detail_screen.dart';
import '../widgets/app_drawer.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  late Future<List<NaturalEvent>> futureEvents;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() {
    setState(() {
      _loading = true;
    });
    futureEvents = EonetService()
        .fetchEvents()
        .whenComplete(() => setState(() => _loading = false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Eventos Naturales - EONET'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<List<NaturalEvent>>(
              future: futureEvents,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No se encontraron eventos.'));
                }

                final events = snapshot.data!;
                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return ListTile(
                      leading: const Icon(Icons.public),
                      title: Text(event.title),
                      subtitle: Text('${event.category} • ${event.date.split("T")[0]}'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EventDetailScreen(event: event),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
