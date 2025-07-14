import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'theme/theme_provider.dart';

void main() {
  runApp(const SpaceExplorerApp());
}

class SpaceExplorerApp extends StatelessWidget {
  const SpaceExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'SpaceExplorer',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: themeProvider.currentTheme,
            darkTheme: themeProvider.currentTheme,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
