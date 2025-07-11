import 'package:flutter/material.dart';
import 'apod_screen.dart';
import 'rover_photos_screen.dart';
import 'event_list_screen.dart';
import 'search_media_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpaceExplorer'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Imagen del Día (APOD)'),
            subtitle: const Text('Explora la imagen astronómica del día'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ApodScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Fotos del Rover'),
            subtitle: const Text('Imágenes reales tomadas en Marte'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RoverPhotosScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Eventos Naturales'),
            subtitle: const Text('Incendios, tormentas, volcanes y otros'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EventListScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Buscar Imágenes'),
            subtitle: const Text('Explora la biblioteca multimedia de la NASA'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchMediaScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Favoritos'),
            subtitle: const Text('Tus APODs'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritesScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
