import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('Acerca de')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SpaceExplorer', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Versión: 1.0.0'),
            SizedBox(height: 10),
            Text('App desarrollada con Flutter utilizando APIs de la NASA para explorar el cosmos.'),
            SizedBox(height: 10),
            Text('Autor: Felipe Pérez Y Juan Rabay'),
            SizedBox(height: 10),
            Text('Proyecto universitario PDS3-2501'),
          ],
        ),
      ),
    );
  }
}
