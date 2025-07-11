import 'package:flutter/material.dart';
import '../core/favorites_service.dart';
import '../models/apod.dart';
import '../widgets/apod_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _service = FavoritesService();
  List<Apod> _favs = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    final favs = await _service.getFavoriteApods();
    setState(() {
      _favs = favs;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _favs.isEmpty
              ? const Center(child: Text('No tienes favoritos'))
              : ListView(
                  children: _favs
                      .map((apod) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ApodCard(apod: apod),
                          ))
                      .toList(),
                ),
    );
  }
}
