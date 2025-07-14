import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/eonet_service.dart';
import '../models/natural_event.dart';
import '../widgets/app_drawer.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  late Future<List<NaturalEvent>> futureEvents;
  bool _loading = true;

  String _status = 'open';
  String? _selectedCategory;
  int _days = 20;

  final List<String?> _categories = [
    null,
    'wildfires',
    'volcanoes',
    'severeStorms',
    'earthquakes',
    'floods',
  ];

  @override
  void initState() {
    super.initState();
    _loadPreferences().then((_) => _fetch());
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _status = prefs.getString('event_status') ?? 'open';
      _selectedCategory = prefs.getString('event_category');
      _days = prefs.getInt('event_days') ?? 20;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('event_status', _status);
    if (_selectedCategory != null) {
      await prefs.setString('event_category', _selectedCategory!);
    } else {
      await prefs.remove('event_category');
    }
    await prefs.setInt('event_days', _days);
  }

  void _fetch() {
    setState(() => _loading = true);
    futureEvents = EonetService()
        .fetchEvents(status: _status, category: _selectedCategory, days: _days)
        .whenComplete(() => setState(() => _loading = false));
  }

  void _showFilterSheet() {
    String tempStatus = _status;
    String? tempCategory = _selectedCategory;
    int tempDays = _days;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Filtrar eventos', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                DropdownButton<String>(
                  value: tempStatus,
                  items: ['open', 'closed']
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (val) => setModalState(() => tempStatus = val!),
                ),
                const SizedBox(height: 10),
                DropdownButton<String?>(
                  value: tempCategory,
                  items: _categories
                      .map((c) => DropdownMenuItem(
                            value: c,
                            child: Text(c == null ? 'Todas las categorías' : c.toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (val) => setModalState(() => tempCategory = val),
                ),
                const SizedBox(height: 10),
                Text('Días: $tempDays'),
                Slider(
                  value: tempDays.toDouble(),
                  min: 1,
                  max: 30,
                  divisions: 29,
                  label: '$tempDays días',
                  onChanged: (val) => setModalState(() => tempDays = val.toInt()),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _status = tempStatus;
                      _selectedCategory = tempCategory;
                      _days = tempDays;
                    });
                    _savePreferences();
                    _fetch();
                  },
                  child: const Text('Aplicar filtros'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _goToDetails(NaturalEvent event, bool compact) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(event.title, style: TextStyle(fontSize: compact ? 18 : 22)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Categoría: ${event.category}', style: TextStyle(fontSize: compact ? 14 : 16)),
            const SizedBox(height: 8),
            Text('Fecha: ${event.date.split("T")[0]}', style: TextStyle(fontSize: compact ? 14 : 16)),
            const SizedBox(height: 8),
            Text(event.description ?? 'Sin descripción', style: TextStyle(fontSize: compact ? 14 : 16)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final compact = context.watch<ThemeProvider>().isCompactMode;

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Eventos Naturales'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: _showFilterSheet,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<List<NaturalEvent>>(
              future: futureEvents,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No se encontraron eventos.'));
                }

                final events = snapshot.data!;
                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return ListTile(
                      leading: const Icon(Icons.warning),
                      title: Text(event.title, style: TextStyle(fontSize: compact ? 14 : 16)),
                      subtitle: Text(
                        '${event.category} • ${event.date.split('T')[0]}',
                        style: TextStyle(fontSize: compact ? 12 : 14),
                      ),
                      onTap: () => _goToDetails(event, compact),
                    );
                  },
                );
              },
            ),
    );
  }
}
