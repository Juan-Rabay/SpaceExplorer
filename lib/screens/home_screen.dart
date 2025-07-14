import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final compact = context.watch<ThemeProvider>().isCompactMode;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('SpaceExplorer'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'lib/assets/splash1.png',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.public,
                      size: compact ? 50 : 80,
                      color: const Color(0xFF66FCF1)),
                  const SizedBox(height: 20),
                  Text(
                    '¡Bienvenido a SpaceExplorer!',
                    style: TextStyle(
                      fontSize: compact ? 18 : 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Explora el cosmos con herramientas asombrosas:\n\n'
                    '- Imagen astronómica del día\n'
                    '- Fotos del Rover en Marte\n'
                    '- Eventos naturales en la Tierra\n'
                    '- Biblioteca multimedia de la NASA\n'
                    '- Tus imágenes favoritas guardadas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: compact ? 12 : 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Builder(
                    builder: (BuildContext innerContext) {
                      return ElevatedButton.icon(
                        onPressed: () => Scaffold.of(innerContext).openDrawer(),
                        icon: const Icon(Icons.menu),
                        label: const Text('Explorar Menú de opciones'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF66FCF1),
                          foregroundColor: Colors.black,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}