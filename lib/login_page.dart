import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wZlot/app_bar.dart';
import 'package:wZlot/drawer.dart';
import 'logout_page.dart';
import 'reset_password_page.dart'; // Dodajemy nową stronę do resetowania hasła

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      navigateWithAnimation(context, const LogoutPage());
    }
  }

  Future<void> _login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      navigateWithAnimation(context, const LogoutPage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _errorMessage =
              'Nie znaleziono użytkownika dla podanego adresu e-mail.';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          _errorMessage = 'Nieprawidłowe hasło.';
        });
      } else {
        setState(() {
          _errorMessage = 'Wystąpił błąd podczas logowania: ${e.message}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "Logowanie"),
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
                textAlign: TextAlign.center,
              ),
            TextFormField(
              controller: _emailController,
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
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResetPasswordPage()), // Przejście do nowej strony
                );
              },
              child: Text(
                'Zapomniałem hasła',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
