import 'package:flutter/material.dart';
import 'package:wZlot/history_page.dart';
import 'package:wZlot/map_page.dart';
import 'package:wZlot/timetable_page.dart';
import 'package:wZlot/registration_page.dart';
import 'package:wZlot/login_page.dart';
import 'package:wZlot/share_page.dart';
import 'package:wZlot/teams_page.dart';
import 'package:wZlot/organizers_page.dart';
import 'package:wZlot/main.dart';

void navigateWithAnimation(BuildContext context, Widget destination) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ),
  );
}


class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        //padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 64,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Zaloguj się'),
            onTap: () {
              navigateWithAnimation(context, const LoginPage()
              );
            },
          ),
          ListTile(
            title: const Text('Strona główna'),
            onTap: () {
              navigateWithAnimation(context, const MyHomePage(title: "Strona główna")
              );
            },
          ),
          ListTile(
            title: const Text('Historia wZlotu'),
            onTap: () {
              navigateWithAnimation(context, const HistoryPage()
              );
            },
          ),
          ListTile(
            title: const Text('Mapa wydarzenia'),
            onTap: () {
              navigateWithAnimation(context, const MapPage()
              );
            },
          ),
          ListTile(
            title: const Text('Harmonogram atrakcji'),
            onTap: () {
              navigateWithAnimation(context, const TimetablePage()
              );
            },
          ),
          ListTile(
            title: const Text('Zapisz się na swoje zajęcia'),
            onTap: () {
              navigateWithAnimation(context, const RegistrationPage()
              );
            },
          ),
          ListTile(
            title: const Text('Pochwal się znajomym!'),
            onTap: () {
              navigateWithAnimation(context, const SharePage()
              );
            },
          ),
          ListTile(
            title: const Text('Poznaj inne drużyny'),
            onTap: () {
              navigateWithAnimation(context, const TeamsPage()
              );
            },
          ),
          ListTile(
            title: const Text('Komenda wZlotu 2024'),
            onTap: () {
              navigateWithAnimation(context, const OrganizersPage()
              );
            },
          ),
        ],
      ),
    );
  }
}
