import 'package:flutter/material.dart';
import '../core/favorites_service.dart';
import '../models/apod.dart';
import '../widgets/apod_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesService _service = FavoritesService();
  List<Apod> _favs = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    _favs = await _service.getFavoriteApods();
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _favs.isEmpty
              ? const Center(child: Text('No tienes favoritos'))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _favs.length,
                  itemBuilder: (_, i) {
                    final apod = _favs[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ApodCard(apod: apod),
                    );
                  },
                ),
    );
  }
}
