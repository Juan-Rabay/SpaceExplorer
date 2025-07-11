import 'package:flutter/material.dart';
import '../core/eonet_service.dart';
import '../models/natural_event.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  late Future<List<NaturalEvent>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = EonetService().fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Eventos Naturales - EONET')),
      body: FutureBuilder<List<NaturalEvent>>(
        future: futureEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
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
                leading: const Icon(Icons.warning_amber),
                title: Text(event.title),
                subtitle: Text('${event.category} • ${event.date.split('T')[0]}'),
              );
            },
          );
        },
      ),
    );
  }
}
