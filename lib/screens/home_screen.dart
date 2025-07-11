import 'package:flutter/material.dart';
import 'apod_screen.dart';
import 'rover_photos_screen.dart';
import 'event_list_screen.dart';
import 'search_media_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpaceExplorer'),
        centerTitle: true,
      ),
      body: ListView(
        children: const [
          _HomeOption(
            title: 'Imagen del Día (APOD)',
            subtitle: 'Explora la imagen astronómica del día',
            page: ApodScreen(),
          ),
          _HomeOption(
            title: 'Fotos del Rover',
            subtitle: 'Imágenes reales tomadas en Marte',
            page: RoverPhotosScreen(),
          ),
          _HomeOption(
            title: 'Eventos Naturales',
            subtitle: 'Incendios, tormentas, volcanes y otros',
            page: EventListScreen(),
          ),
          _HomeOption(
            title: 'Buscar Imágenes',
            subtitle: 'Explora la biblioteca multimedia de la NASA',
            page: SearchMediaScreen(),
          ),
          _HomeOption(
            title: 'Favoritos',
            subtitle: 'Tus APODs guardados',
            page: FavoritesScreen(),
          ),
        ],
      ),
    );
  }
}

class _HomeOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget page;

  const _HomeOption({
    required this.title,
    required this.subtitle,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
    );
  }
}
