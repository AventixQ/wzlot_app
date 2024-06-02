import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wZlot/app_bar.dart';
import 'package:wZlot/drawer.dart';
import 'package:wZlot/event_datails.dart';
import 'package:wZlot/timetable_page.dart';
import 'login_page.dart';
import 'package:wZlot/string_events.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: const MainAppBar(title: "Twoje zajęcia"),
      drawer: const MainDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (user == null)
              Column(
                children: [
                  Text(
                    'Zaloguj się, aby przeglądać swoje zajęcia.',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text('Przejdź do logowania'),
                  ),
                ],
              ),
            if (user != null)
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>?>(
                  future: fetchUserEvents(user),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text('Wystąpił błąd: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('Jeszcze nie zapisałeś się na żadne zajęcia.');
                    } else {
                      final events = snapshot.data!;
                      return ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index];
                          return ListTile(
                            title: Text(event['name']),
                            subtitle: Text(event['lecturer']),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EventDetailsPage(event: event),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            SizedBox(height: 20),
            if (user != null)
              ElevatedButton(
                onPressed: () {
                  navigateWithAnimation(context, const TimetablePage());
                },
                child: Text('Przejdź do harmonogramu'),
              ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>?> fetchUserEvents(User user) async {
    final String? username = StringEvents.removeSpecialCharacters(user.email);
    if (username == null) {
      return [];
    }

    final userDatabaseReference =
        FirebaseDatabase.instance.ref().child('users/$username');
    final DatabaseEvent userEvent = await userDatabaseReference.once();
    final userData = userEvent.snapshot.value as Map<dynamic, dynamic>?;
    String? selectedEvents = userData?["selected_events"];
    if (selectedEvents == null || selectedEvents.isEmpty) {
      return [];
    }

    List<String> eventIds = selectedEvents.split(';');
    List<Map<String, dynamic>> events = [];

    final eventsDatabaseReference =
        FirebaseDatabase.instance.ref().child('events');
    for (String eventId in eventIds) {
      final eventSnapshot = await eventsDatabaseReference.child(eventId).once();
      final event = eventSnapshot.snapshot.value as Map<dynamic, dynamic>?;
      if (event != null) {
        events.add(event.cast<String, dynamic>());
      }
    }
    return events;
  }
}
