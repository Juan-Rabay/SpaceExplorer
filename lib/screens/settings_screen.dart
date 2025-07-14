import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../theme/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final compact = themeProvider.isCompactMode;

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('Preferencias')),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(
              'Modo oscuro',
              style: TextStyle(fontSize: compact ? 14 : 18),
            ),
            subtitle: Text(
              'Activa o desactiva el modo oscuro',
              style: TextStyle(fontSize: compact ? 12 : 14),
            ),
            value: themeProvider.isDarkMode,
            onChanged: (val) => themeProvider.toggleTheme(val),
          ),
          SwitchListTile(
            title: Text(
              'Modo compacto',
              style: TextStyle(fontSize: compact ? 14 : 18),
            ),
            subtitle: Text(
              'Reduce el tamaño de fuentes e imágenes',
              style: TextStyle(fontSize: compact ? 12 : 14),
            ),
            value: themeProvider.isCompactMode,
            onChanged: (val) => themeProvider.toggleCompactMode(val),
          ),
        ],
      ),
    );
  }
}
