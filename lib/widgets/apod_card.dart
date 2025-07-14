import 'package:flutter/material.dart';
import '../models/apod.dart';

class ApodCard extends StatelessWidget {
  final Apod apod;
  final bool compactMode;

  const ApodCard({
    super.key,
    required this.apod,
    this.compactMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            apod.url,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) {
              return const Icon(Icons.broken_image, size: 100);
            },
          ),
          const SizedBox(height: 10),
          Text(
            apod.title,
            style: TextStyle(
              fontSize: compactMode ? 18 : 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.all(compactMode ? 8.0 : 12.0),
            child: Text(
              apod.explanation,
              style: TextStyle(fontSize: compactMode ? 14 : 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: compactMode ? 8 : 12),
            child: Text(
              "Fecha: ${apod.date}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: compactMode ? 12 : 14),
            ),
          ),
        ],
      ),
    );
  }
}
