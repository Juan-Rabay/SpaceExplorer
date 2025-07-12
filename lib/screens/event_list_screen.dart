import 'package:flutter/material.dart';
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
  String _selectedType = 'all';
  DateTime? _startDate;
  DateTime? _endDate;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() {
    setState(() {
      _loading = true;
    });
    futureEvents = EonetService()
        .fetchEvents(type: _selectedType, startDate: _startDate, endDate: _endDate)
        .whenComplete(() => setState(() => _loading = false));
  }

  void _showFilterSheet() {
    String tempType = _selectedType;
    DateTime? tempStart = _startDate;
    DateTime? tempEnd = _endDate;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Filtrar por tipo de evento'),
                DropdownButton<String>(
                  value: tempType,
                  items: [
                    'all', 'FLR', 'SEP', 'CME', 'IPS',
                    'MPC', 'GST', 'RBE', 'report'
                  ].map((t) => DropdownMenuItem(
                        value: t,
                        child: Text(t.toUpperCase()),
                      )).toList(),
                  onChanged: (val) => setModalState(() => tempType = val!),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: tempStart ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) setModalState(() => tempStart = picked);
                  },
                  child: Text(tempStart != null
                      ? 'Desde: ${tempStart!.toLocal().toString().split(' ')[0]}'
                      : 'Seleccionar fecha de inicio'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: tempEnd ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) setModalState(() => tempEnd = picked);
                  },
                  child: Text(tempEnd != null
                      ? 'Hasta: ${tempEnd!.toLocal().toString().split(' ')[0]}'
                      : 'Seleccionar fecha de fin'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedType = tempType;
                      _startDate = tempStart;
                      _endDate = tempEnd;
                    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Eventos Naturales - EONET'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: _showFilterSheet,
          )
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
                      leading: const Icon(Icons.warning_amber),
                      title: Text(event.title),
                      subtitle:
                          Text('${event.category} • ${event.date.split('T')[0]}'),
                    );
                  },
                );
              },
            ),
    );
  }
}
