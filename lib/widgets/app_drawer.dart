import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/apod_screen.dart';
import '../screens/rover_photos_screen.dart';
import '../screens/event_list_screen.dart';
import '../screens/search_media_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/about_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context); // Cierra el drawer
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF1F2833),
            ),
            child: Text(
              'Explora el Universo',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () => _navigateTo(context, const HomeScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Imagen del Día'),
            onTap: () => _navigateTo(context, const ApodScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text('Fotos del Rover'),
            onTap: () => _navigateTo(context, const RoverPhotosScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.public),
            title: const Text('Eventos Naturales'),
            onTap: () => _navigateTo(context, const EventListScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Buscar Imágenes'),
            onTap: () => _navigateTo(context, const SearchMediaScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Favoritos'),
            onTap: () => _navigateTo(context, const FavoritesScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Preferencias'),
            onTap: () => _navigateTo(context, const SettingsScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Acerca de'),
            onTap: () => _navigateTo(context, const AboutScreen()),
          ),
        ],
      ),
    );
  }
}
