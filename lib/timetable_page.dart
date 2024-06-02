import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wZlot/app_bar.dart';
import 'package:wZlot/drawer.dart';

class TimetablePage extends StatelessWidget {
  const TimetablePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "Harmonogram wydarzenia"),
      drawer: MainDrawer(),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('wydarzenia').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Wystąpił błąd: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            List<String> eventNames = [];
            snapshot.data!.docs.forEach((DocumentSnapshot doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              eventNames.add(data['name']);
            });

            return ListView.builder(
              itemCount: eventNames.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(eventNames[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
