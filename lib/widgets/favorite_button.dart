import 'package:flutter/material.dart';
import '../models/apod.dart';
import '../core/favorites_service.dart';

class FavoriteButton extends StatefulWidget {
  final Apod apod;
  const FavoriteButton({super.key, required this.apod});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;
  final _service = FavoritesService();

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  void _loadStatus() async {
    final fav = await _service.isApodFavorite(widget.apod);
    setState(() => _isFavorite = fav);
  }

  void _toggle() async {
    if (_isFavorite) {
      await _service.removeApod(widget.apod);
    } else {
      await _service.addApod(widget.apod);
    }
    setState(() => _isFavorite = !_isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
      ),
      onPressed: _toggle,
    );
  }
}
