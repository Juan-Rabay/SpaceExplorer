import 'package:flutter/material.dart';
import '../core/rover_service.dart';
import '../models/rover_photo.dart';
import '../core/connectivity_service.dart';

class RoverPhotosScreen extends StatefulWidget {
  const RoverPhotosScreen({Key? key}) : super(key: key);

  @override
  State<RoverPhotosScreen> createState() => RoverPhotosScreenState();
}

class RoverPhotosScreenState extends State<RoverPhotosScreen> {
  late Future<List<RoverPhoto>> _futurePhotos;
  bool _loading = true;
  bool _offline = false;
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
      _futurePhotos = RoverService().fetchPhotos();
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Fotos del Rover')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_offline) {
      return Scaffold(
        appBar: AppBar(title: const Text('Fotos del Rover Offline')),
        body: const Center(child: Text('Sin conexión a internet')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Fotos del Rover')),
      body: FutureBuilder<List<RoverPhoto>>(
        future: _futurePhotos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron fotos.'));
          }

          final photos = snapshot.data!;
          return ListView.builder(
            itemCount: photos.length,
            itemBuilder: (_, i) {
              final p = photos[i];
              return Card(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Image.network(p.imgSrc),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(p.roverName,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Cámara: ${p.cameraName}'),
                          Text('Fecha en Tierra: ${p.earthDate}'),
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
