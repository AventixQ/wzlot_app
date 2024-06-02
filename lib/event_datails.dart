import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:wZlot/string_events.dart';

class EventDetailsPage extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventDetailsPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    bool isEventFull = event['curr_part'] >= event['max_part'];
    final String? username = StringEvents.removeSpecialCharacters(user?.email);
    final String eventName = event['name'];
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (user == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Aby dokonywać zmian w swoich zajęciach, zaloguj się na swoje konto'),
                  ));
                } else if (isEventFull) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Limit osób na te zajęcia został przekroczony! Poczekaj, aż się zwolni miejsce lub wybierz inne zajęcia.'),
                  ));
                } else {
                  if (username != null) {
                    final databaseReference = FirebaseDatabase.instance
                        .ref()
                        .child('users/$username');
                    databaseReference.once().then((DatabaseEvent user) {
                      final userData =
                          user.snapshot.value as Map<dynamic, dynamic>?;
                      String? selectedEvents = userData?["selected_events"];

                      if (StringEvents.contains(selectedEvents, eventName) ==
                          true) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Już jesteś zapisany na te zajęcia!'),
                        ));
                      } else {
                        selectedEvents =
                            StringEvents.add(selectedEvents, eventName);
                        event.update('curr_part', (value) => value + 1);
                        
                        databaseReference.update(
                            {'selected_events': selectedEvents}).then((_) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Zostałeś zapisany na zajęcia.'),
                          ));
                        }).catchError((error) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Wystąpił błąd. Spróbuj ponownie.'),
                          ));
                        });
                      }
                    }).catchError((error) {
                      print(error);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Wystąpił błąd. Spróbuj ponownie.'),
                      ));
                    });
                  }
                }
              },
              child: Text('Zapisz się na zajęcia'),
            ),
          ],
        ),
      ),
    );
    
  }
}
