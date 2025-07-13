import 'package:flutter/material.dart';
import '../models/natural_event.dart';

class EventDetailScreen extends StatelessWidget {
  final NaturalEvent event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              event.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Categoría: ${event.category}'),
            const SizedBox(height: 5),
            Text('Fuente: ${event.source}'),
            const SizedBox(height: 5),
            Text('Fecha: ${event.date.split("T")[0]}'),
            const SizedBox(height: 10),
            if (event.description != null)
              Text('Descripción:\n${event.description}', textAlign: TextAlign.justify),
            const SizedBox(height: 10),
            if (event.latitude != null && event.longitude != null)
              Text('Ubicación aproximada:\nLat: ${event.latitude}, Lon: ${event.longitude}'),
          ],
        ),
      ),
    );
  }
}
