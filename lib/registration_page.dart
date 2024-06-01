import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wZlot/drawer.dart';
import 'package:wZlot/scheadule_page.dart';
import 'login_page.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Formularz rejestracyjny'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (user == null)
              Column(
                children: [
                  Text(
                    'Zaloguj się, aby zarejestrować się na zajęcia.',
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
            SizedBox(height: 20),
            if (user != null)
              ElevatedButton(
                onPressed: () {
                  navigateWithAnimation(context, const SchedulePage());
                },
                child: Text('Przejdź do harmonogramu'),
              ),
          ],
        ),
      ),
    );
  }
}
