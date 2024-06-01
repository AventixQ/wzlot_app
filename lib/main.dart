import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wZlot/app_bar.dart';
import 'package:wZlot/drawer.dart';
import 'package:wZlot/fire_animation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
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
        appBar: const MainAppBar(title: "wZlot"),
        drawer: const MainDrawer(),
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
                          ? const BouncingImage()
                          : Image.asset("images\\fire.png"),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _showAnimation
                          ? const BlinkingSparkles()
                          : Container(),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                          "images\\wood.png"), // Dodaj grafikę wood tutaj
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
