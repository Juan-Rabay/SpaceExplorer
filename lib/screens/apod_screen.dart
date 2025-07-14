import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/apod.dart';
import '../widgets/apod_card.dart';
import '../widgets/favorite_button.dart';
import '../core/constants.dart';
import '../core/api_client.dart';
import '../core/connectivity_service.dart';
import '../core/favorites_service.dart';
import '../widgets/app_drawer.dart';
import '../theme/theme_provider.dart';

class ApodScreen extends StatefulWidget {
  const ApodScreen({super.key});

  @override
  State<ApodScreen> createState() => _ApodScreenState();
}

class _ApodScreenState extends State<ApodScreen> {
  Apod? _apod;
  bool _loading = true;
  String? _error;
  bool _offline = false;

  final _conn = ConnectivityService();
  final _favService = FavoritesService();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final online = await _conn.isOnline;
    if (!online) {
      final favs = await _favService.getFavoriteApods();
      setState(() {
        _offline = true;
        _loading = false;
        _apod = favs.isNotEmpty ? favs.first : null;
      });
    } else {
      await fetchApod();
    }
  }

  Future<void> fetchApod() async {
    try {
      final client = ApiClient();
      final data = await client.getJson('$apodUrl?api_key=$nasaApiKey');
      setState(() {
        _apod = Apod.fromJson(data);
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error al cargar los datos: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = _offline ? 'Imagen del Día (Sin conexión)' : 'Imagen del Día';
    final compact = context.watch<ThemeProvider>().isCompactMode;

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text(title),
        actions: [
          if (_apod != null) ...[
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                Share.share(
                  '${_apod!.title}\n${_apod!.url}',
                  subject: 'Imagen astronómica del día',
                );
              },
            ),
            FavoriteButton(apod: _apod!),
          ],
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : _apod != null
                  ? ApodCard(apod: _apod!, compactMode: compact)
                  : const Center(child: Text('Sin datos.')),
    );
  }
}
