import 'package:flutter/material.dart';
import 'package:wZlot/app_bar.dart';
import 'package:wZlot/drawer.dart';


class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MainAppBar(title: "Mapa terenu wZlotowego"),
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