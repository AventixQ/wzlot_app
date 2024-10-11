import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wZlot/app_bar.dart';
import 'package:wZlot/drawer.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  final String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  final RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text.trim());
        setState(() {
          _errorMessage = "E-mail z resetowaniem hasła został wysłany.";
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            _errorMessage = "Nie znaleziono użytkownika z tym adresem e-mail.";
          });
        } else {
          setState(() {
            _errorMessage = "Wystąpił błąd: ${e.message}";
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resetowanie hasła"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Podaj maila, na którego wyślemy nowe hasło",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Proszę podać adres e-mail';
                  } else if (!regex.hasMatch(value)) {
                    return 'Proszę podać poprawny adres e-mail';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetPassword,
                child: Text('Resetuj hasło'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
