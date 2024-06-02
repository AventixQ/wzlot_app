import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventDetailsPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nazwa: ${event['name']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Maksymalna liczba uczestników: ${event['max_part']}'),
            const SizedBox(height: 8),
            Text('Aktualna liczba uczestników: ${event['curr_part']}'),
            const SizedBox(height: 8),
            Text('Data: ${event['date']}'),
            const SizedBox(height: 8),
            Text('Czas trwania: ${event['length']} godziny'),
            const SizedBox(height: 8),
            Text('Miejsce: ${event['place']}'),
            const SizedBox(height: 8),
            Text('Blok zajęć: ${event['block_numb']}'),
            const SizedBox(height: 8),
            Text('Prowadzący: ${event['lecturer']}'),
            const SizedBox(height: 8),
            Text('Opis: ${event['description']}'),
          ],
        ),
      ),
    );
  }
}
