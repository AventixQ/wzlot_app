import 'package:flutter/material.dart';
import 'package:w_zlot/app_bar.dart';
import 'package:w_zlot/drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SharePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "Pochal się gdzie jesteś!"),
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