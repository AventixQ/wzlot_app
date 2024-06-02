import 'dart:async';
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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
              const SizedBox(height: 20),
              const Text(
                'Czas do oficjalnego rozpoczęcia wydarzenia:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const CountdownTimer(),
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
                      child: Image.asset("images\\wood.png"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({Key? key}) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  Duration _duration = const Duration();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    final eventDate = DateTime.parse('2024-09-22 18:00:00Z');;
    final now = DateTime.now();
    setState(() {
      _duration = eventDate.difference(now);
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        final now = DateTime.now();
        _duration = eventDate.difference(now);
      });
    });
  }

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    final days = _duration.inDays;
    final hours = _duration.inHours.remainder(24);
    final minutes = _duration.inMinutes.remainder(60);
    final seconds = _duration.inSeconds.remainder(60);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTimeBlock(days, 'dni'),
        _buildTimeBlock(hours, 'godziny'),
        _buildTimeBlock(minutes, 'minuty'),
        _buildTimeBlock(seconds, 'sekundy'),
      ],
    );
  }

  Widget _buildTimeBlock(int value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text(
            _formatNumber(value),
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
