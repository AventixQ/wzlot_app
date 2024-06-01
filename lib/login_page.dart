import 'package:w_zlot/app_bar.dart';
import 'package:w_zlot/drawer.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorMessage;

  void _login() {
    // Tutaj dodaj logikę autoryzacji, na przykład za pomocą Firebase Authentication
    // Po udanym logowaniu przekieruj użytkownika na inną stronę

    // Przykład walidacji (tylko dla demonstracji)
    if (_loginController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Proszę wprowadzić adres login i hasło.';
      });
      return;
    }

    // Tutaj możesz wywołać funkcję logowania
    // np. _authenticateUser(_loginController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "Formularz rejestracyjny"),
      drawer: MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            TextFormField(
              controller: _loginController,
              decoration: InputDecoration(labelText: 'Login'),
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Hasło'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Zaloguj'),
            ),
          ],
        ),
      ),
    );
  }
}
