import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../theme/theme_provider.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final compact = context.watch<ThemeProvider>().isCompactMode;

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('Acerca de')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SpaceExplorer',
                style: TextStyle(
                  fontSize: compact ? 20 : 24,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 10),
            const Text('Versión: 1.0.0'),
            const SizedBox(height: 10),
            const Text('App desarrollada con Flutter utilizando APIs de la NASA para explorar el cosmos.'),
            const SizedBox(height: 10),
            const Text('Autores: Felipe Pérez y Juan Rabay'),
            const SizedBox(height: 10),
            const Text('Proyecto universitario PDS3-2501'),
          ],
        ),
      ),
    );
  }
}
