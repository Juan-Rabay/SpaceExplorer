import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import 'package:flutter/material.dart';
import '../models/natural_event.dart';

class EventDetailScreen extends StatelessWidget {
  final NaturalEvent event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final compact = context.watch<ThemeProvider>().isCompactMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title, style: TextStyle(fontSize: compact ? 18 : 22)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              event.title,
              style: TextStyle(
                fontSize: compact ? 18 : 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('Categoría: ${event.category}', style: TextStyle(fontSize: compact ? 14 : 16)),
            const SizedBox(height: 5),
            Text('Fuente: ${event.source}', style: TextStyle(fontSize: compact ? 14 : 16)),
            const SizedBox(height: 5),
            Text('Fecha: ${event.date.split("T")[0]}', style: TextStyle(fontSize: compact ? 14 : 16)),
            const SizedBox(height: 10),
            if (event.description != null)
              Text(
                'Descripción:\n${event.description}',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: compact ? 14 : 16),
              ),
            const SizedBox(height: 10),
            if (event.latitude != null && event.longitude != null)
              Text(
                'Ubicación aproximada:\nLat: ${event.latitude}, Lon: ${event.longitude}',
                style: TextStyle(fontSize: compact ? 14 : 16),
              ),
          ],
        ),
      ),
    );
  }
}
