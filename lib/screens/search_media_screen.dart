import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import 'package:flutter/material.dart';
import '../core/media_service.dart';
import '../models/media_item.dart';
import '../core/connectivity_service.dart';
import '../widgets/app_drawer.dart';

class SearchMediaScreen extends StatefulWidget {
  const SearchMediaScreen({Key? key}) : super(key: key);

  @override
  State<SearchMediaScreen> createState() => SearchMediaScreenState();
}

class SearchMediaScreenState extends State<SearchMediaScreen> {
  final _controller = TextEditingController();
  List<MediaItem> _results = [];
  bool _loading = false;
  bool _offline = false;
  String? _error;
  final _conn = ConnectivityService();

  Future<void> _search(String query) async {
    final online = await _conn.isOnline;
    if (!online) {
      setState(() {
        _offline = true;
        _error = 'Sin conexión a internet';
        _loading = false;
      });
      return;
    }

    setState(() {
      _offline = false;
      _loading = true;
      _error = null;
    });

    try {
      _results = await MediaService().searchMedia(query);
    } catch (e) {
      _error = 'Error al buscar: $e';
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final compact = context.watch<ThemeProvider>().isCompactMode;

    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Imágenes NASA')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            if (_offline)
              const Text(
                'Sin conexión a internet',
                style: TextStyle(color: Colors.red),
              ),
            TextField(
              controller: _controller,
              onSubmitted: _search,
              decoration: InputDecoration(
                hintText: 'Ejemplo: Mars, Moon, Saturn, etc.',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _search(_controller.text),
                ),
              ),
              style: TextStyle(fontSize: compact ? 12 : 16),
            ),
            const SizedBox(height: 10),
            if (_loading)
              const Center(child: CircularProgressIndicator())
            else if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (_, i) {
                    final item = _results[i];
                    return Card(
                      child: ListTile(
                        leading: Image.network(
                          item.imageUrl,
                          width: compact ? 40 : 50,
                          height: compact ? 40 : 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          item.title,
                          style: TextStyle(fontSize: compact ? 14 : 18),
                        ),
                        subtitle: Text(
                          item.description,
                          style: TextStyle(fontSize: compact ? 12 : 14),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
