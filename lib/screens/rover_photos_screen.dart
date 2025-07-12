import 'package:flutter/material.dart';
import '../core/rover_service.dart';
import '../models/rover_photo.dart';
import '../core/connectivity_service.dart';
import '../widgets/app_drawer.dart';

class RoverPhotosScreen extends StatefulWidget {
  const RoverPhotosScreen({super.key});

  @override
  State<RoverPhotosScreen> createState() => _RoverPhotosScreenState();
}

class _RoverPhotosScreenState extends State<RoverPhotosScreen> {
  late Future<List<RoverPhoto>> futurePhotos;
  String _selectedRover = 'curiosity';
  DateTime? _selectedDate;

  final _conn = ConnectivityService();
  bool _offline = false;

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
        futurePhotos = Future.value([]); // podrías cargar desde caché si aplicas
      });
    } else {
      _applyFilters();
    }
  }

  void _applyFilters() {
    setState(() {
      _offline = false;
      futurePhotos = RoverService().fetchPhotos(
        rover: _selectedRover,
        earthDate: _selectedDate,
      );
    });
  }

void _showFilterSheet() {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      String tempRover = _selectedRover;
      DateTime? tempDate = _selectedDate;

      return StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Selecciona el Rover'),
                DropdownButton<String>(
                  value: tempRover,
                  items: ['curiosity', 'opportunity', 'spirit']
                      .map((rover) => DropdownMenuItem(
                            value: rover,
                            child: Text(rover.toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setModalState(() => tempRover = value);
                    }
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: tempDate ?? DateTime.now(),
                      firstDate: DateTime(2004),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setModalState(() => tempDate = picked);
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    tempDate != null
                        ? 'Fecha: ${tempDate != null ? tempDate!.toLocal().toString().split(' ')[0] : ''}'
                        : 'Seleccionar fecha',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedRover = tempRover;
                      _selectedDate = tempDate;
                    });
                    _applyFilters();
                  },
                  child: const Text('Aplicar filtros'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_offline ? 'Fotos del Rover (Offline)' : 'Fotos del Rover'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: _showFilterSheet,
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder<List<RoverPhoto>>(
        future: futurePhotos,
        builder: (context, snapshot) {
          if (_offline) {
            return const Center(
              child: Text('Sin conexión. Conéctate para cargar las fotos.'),
            );
          }

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
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
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