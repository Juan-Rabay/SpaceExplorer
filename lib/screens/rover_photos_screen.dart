import 'package:flutter/material.dart';
import '../core/rover_service.dart';
import '../models/rover_photo.dart';

class RoverPhotosScreen extends StatefulWidget {
  const RoverPhotosScreen({super.key});

  @override
  State<RoverPhotosScreen> createState() => _RoverPhotosScreenState();
}

class _RoverPhotosScreenState extends State<RoverPhotosScreen> {
  late Future<List<RoverPhoto>> futurePhotos;

  @override
  void initState() {
    super.initState();
    futurePhotos = RoverService().fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fotos del Rover')),
      body: FutureBuilder<List<RoverPhoto>>(
        future: futurePhotos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron fotos.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final photo = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Image.network(photo.imgSrc),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(photo.roverName,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Cámara: ${photo.cameraName}'),
                          Text('Fecha en Tierra: ${photo.earthDate}'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
