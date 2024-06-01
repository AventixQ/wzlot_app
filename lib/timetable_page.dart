import 'package:flutter/material.dart';
import 'package:wZlot/app_bar.dart';
import 'package:wZlot/drawer.dart';

class TimetablePage extends StatelessWidget {
  const TimetablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MainAppBar(title: "Harmonogram wydarzenia"),
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