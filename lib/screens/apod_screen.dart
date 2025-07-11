import 'package:flutter/material.dart';
import '../models/apod.dart';
import '../widgets/apod_card.dart';
import '../widgets/favorite_button.dart';
import '../core/constants.dart';
import '../core/api_client.dart';

class ApodScreen extends StatefulWidget {
  const ApodScreen({super.key});

  @override
  State<ApodScreen> createState() => _ApodScreenState();
}

class _ApodScreenState extends State<ApodScreen> {
  Apod? _apod;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    fetchApod();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imagen del Día'),
        actions: [
          if (_apod != null)
            FavoriteButton(apod: _apod!),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : _apod != null
                  ? ApodCard(apod: _apod!)
                  : const Center(child: Text('Sin datos.')),
    );
  }
}
