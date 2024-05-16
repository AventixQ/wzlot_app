import 'package:flutter/material.dart';
import 'package:w_zlot/app_bar.dart';
import 'package:w_zlot/drawer.dart';

class OrganizersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "Komenda wZlotu"),
      drawer: MainDrawer(),
      body: Center(
        child: Text(
          'Hello World!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}