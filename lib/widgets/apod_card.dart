import 'package:flutter/material.dart';
import '../models/apod.dart';

class ApodCard extends StatelessWidget {
  final Apod apod;

  const ApodCard({super.key, required this.apod});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(apod.url, errorBuilder: (context, error, stack) {
            return const Icon(Icons.broken_image, size: 100);
          }),
          const SizedBox(height: 10),
          Text(
            apod.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              apod.explanation,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text("Fecha: ${apod.date}"),
        ],
      ),
    );
  }
}
