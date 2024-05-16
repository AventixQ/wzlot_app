import 'package:flutter/material.dart';
import 'package:w_zlot/fire_animation.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wZlot App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
        fontFamily: 'Museo',
      ),
      home: const MyHomePage(title: 'wZlot'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showAnimation = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showAnimation = true;
        });
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              _showAnimation = false;
            });
          }
        });
      },
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          //padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 64,
              child: DrawerHeader(
                child: Text(
                  'Menu',
                  style: TextStyle(fontWeight: FontWeight.w700,),
                  ),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                ),
              ),
            ),
            ListTile(
              title: Text('Historia wZlotu'),
              onTap: () {
                // TODO: funkcja dla Opcji
              },
            ),
            ListTile(
              title: Text('Mapa wydarzenia'),
              onTap: () {
                // TODO: funkcja dla Opcji
              },
            ),
            ListTile(
              title: Text('Harmonogram atrakcji'),
              onTap: () {
                // TODO: funkcja dla Opcji
              },
            ),
            ListTile(
              title: Text('Zapisz się na swoje zajęcia'),
              onTap: () {
                // TODO: funkcja dla Opcji
              },
            ),
            ListTile(
              title: Text('Pochwal się znajomym!'),
              onTap: () {
                // TODO: funkcja dla Opcji
              },
            ),
            ListTile(
              title: Text('Poznaj inne drużyny'),
              onTap: () {
                // TODO: funkcja dla Opcji
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Wędrowniku!',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
            ),
            const Text(
              'Witamy ciebie w oficjalnej aplikacji wZlotowej',
            ),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _showAnimation
                    ? BouncingImage()
                    : Image.asset("images\\fire.png"),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _showAnimation
                    ? BlinkingSparkles()
                    : Container(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset("images\\wood.png"), // Dodaj grafikę wood tutaj
                ),
              ],
            ),
          )

          ],
        ),
      ),
    ),);
  }
}