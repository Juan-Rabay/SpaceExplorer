import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('SpaceExplorer'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.public, size: 80, color: Color(0xFF66FCF1)),
              const SizedBox(height: 20),
              const Text(
                '¡Bienvenido a SpaceExplorer!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Explora el cosmos con herramientas asombrosas:\n\n• Imagen astronómica del día\n• Fotos del Rover en Marte\n• Eventos naturales en la Tierra\n• Biblioteca multimedia de la NASA\n• Tus imágenes favoritas guardadas',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu),
                label: const Text('Explorar Menú'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
