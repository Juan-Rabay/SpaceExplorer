import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _compactMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('Preferencias')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Modo compacto'),
            subtitle: const Text('Reduce el tamaño de fuentes e imágenes'),
            value: _compactMode,
            onChanged: (val) {
              setState(() {
                _compactMode = val;
              });
            },
          ),
        ],
      ),
    );
  }
}