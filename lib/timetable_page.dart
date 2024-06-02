import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:wZlot/app_bar.dart';
import 'package:wZlot/drawer.dart';
import 'package:wZlot/event_datails.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  final databaseReference = FirebaseDatabase.instance.ref().child('events');

  Map<String, Map<int, List<Map<String, dynamic>>>> sortedEvents = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    databaseReference.once().then((DatabaseEvent event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        setState(() {
          sortedEvents.clear();
          data.forEach((key, value) {
            if (value is Map) {
              String date = value['date'] as String;
              int block = value['block_numb'] as int;
              Map<String, dynamic> eventDetails = {
                'name': value['name'] as String,
                'lecturer': value['lecturer'] as String,
                'max_part': value['max_part'] as int,
                'curr_part': value['curr_part'] as int,
                'date': value['date'] as String,
                'length': value['length'] as int,
                'place': value['place'] as String,
                'block_numb': value['block_numb'] as int,
                'description': value['description'] as String,
              };

              if (!sortedEvents.containsKey(date)) {
                sortedEvents[date] = {};
              }
              if (!sortedEvents[date]!.containsKey(block)) {
                sortedEvents[date]![block] = [];
              }
              sortedEvents[date]![block]!.add(eventDetails);
            }
          });
        });
      }
    }).catchError((error) {
      // Obsługa błędów
      print('Błąd pobierania danych: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: "Harmonogram wydarzenia"),
      drawer: const MainDrawer(),
      body: Center(
        child: sortedEvents.isEmpty
            ? const CircularProgressIndicator()
            : ListView(
                children: sortedEvents.keys.map((date) {
                  return ExpansionTile(
                    title: Text(date),
                    children: sortedEvents[date]!.keys.map((block) {
                      return ExpansionTile(
                        title: Text('Blok $block'),
                        children: sortedEvents[date]![block]!.map((event) {
                          return ListTile(
                            title: Text(event['name']),
                            subtitle: Text('Prowadzący: ${event['lecturer']}'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EventDetailsPage(event: event),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
