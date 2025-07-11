import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/space_theme.dart';
void main() {
  runApp(const SpaceExplorerApp());
}

class SpaceExplorerApp extends StatelessWidget {
  const SpaceExplorerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceExplorer',
      debugShowCheckedModeBanner: false,
      theme: spaceTheme,
      home: const HomeScreen(),
    );
  }
}
