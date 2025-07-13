import 'package:flutter/material.dart';
import '../core/rover_service.dart';
import '../models/rover_photo.dart';
import '../widgets/app_drawer.dart';

class RoverPhotosScreen extends StatefulWidget {
  const RoverPhotosScreen({super.key});

  @override
  State<RoverPhotosScreen> createState() => _RoverPhotosScreenState();
}

class _RoverPhotosScreenState extends State<RoverPhotosScreen> {
  final _service = RoverService();
  late Future<List<RoverPhoto>> futurePhotos;

  String selectedRover = 'curiosity';
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  void _loadPhotos() {
    setState(() {
      futurePhotos = _service.fetchPhotos(
        rover: selectedRover,
        earthDate: selectedDate,
      );
    });
  }

  void _showFilterSheet() {
    String tempRover = selectedRover;
    DateTime? tempDate = selectedDate;

    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Selecciona el Rover'),
              DropdownButton<String>(
                value: tempRover,
                items: const [
                  DropdownMenuItem(value: 'curiosity', child: Text('Curiosity')),
                  DropdownMenuItem(value: 'opportunity', child: Text('Opportunity')),
                  DropdownMenuItem(value: 'spirit', child: Text('Spirit')),
                ],
                onChanged: (val) {
                  setModalState(() {
                    tempRover = val!;
                  });
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: tempDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) setModalState(() => tempDate = picked);
                },
                child: Text(tempDate != null
                    ? 'Fecha: ${tempDate!.toLocal().toString().split(' ')[0]}'
                    : 'Seleccionar Fecha'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    selectedRover = tempRover;
                    selectedDate = tempDate;
                  });
                  _loadPhotos();
                },
                child: const Text('Aplicar Filtros'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Fotos del Rover'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: _showFilterSheet,
          )
        ],
      ),
      body: FutureBuilder<List<RoverPhoto>>(
        future: futurePhotos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final photos = snapshot.data;
          if (photos == null || photos.isEmpty) {
            return const Center(child: Text('No se encontraron fotos.'));
          }
          return ListView.builder(
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final photo = photos[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(photo.imgSrc),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Rover: ${photo.roverName}, Cámara: ${photo.cameraName}, Fecha: ${photo.earthDate}'),
                    )
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
