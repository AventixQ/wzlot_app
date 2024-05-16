import 'package:flutter/material.dart';
import 'package:w_zlot/history_page.dart';
import 'package:w_zlot/map_page.dart';
import 'package:w_zlot/timetable_page.dart';
import 'package:w_zlot/registration_page.dart';
import 'package:w_zlot/share_page.dart';
import 'package:w_zlot/teams_page.dart';
import 'package:w_zlot/organizers_page.dart';
import 'package:w_zlot/main.dart';

void navigateWithAnimation(BuildContext context, Widget destination) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
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
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        //padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 64,
            child: DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
              ),
            ),
          ),
          ListTile(
            title: Text('Strona główna'),
            onTap: () {
              navigateWithAnimation(context, MyHomePage(title: "Strona główna")
              );
            },
          ),
          ListTile(
            title: Text('Historia wZlotu'),
            onTap: () {
              navigateWithAnimation(context, HistoryPage()
              );
            },
          ),
          ListTile(
            title: Text('Mapa wydarzenia'),
            onTap: () {
              navigateWithAnimation(context, MapPage()
              );
            },
          ),
          ListTile(
            title: Text('Harmonogram atrakcji'),
            onTap: () {
              navigateWithAnimation(context, TimetablePage()
              );
            },
          ),
          ListTile(
            title: Text('Zapisz się na swoje zajęcia'),
            onTap: () {
              navigateWithAnimation(context, RegistrationPage()
              );
            },
          ),
          ListTile(
            title: Text('Pochwal się znajomym!'),
            onTap: () {
              navigateWithAnimation(context, SharePage()
              );
            },
          ),
          ListTile(
            title: Text('Poznaj inne drużyny'),
            onTap: () {
              navigateWithAnimation(context, TeamsPage()
              );
            },
          ),
          ListTile(
            title: Text('Komenda wZlotu 2024'),
            onTap: () {
              navigateWithAnimation(context, OrganizersPage()
              );
            },
          ),
        ],
      ),
    );
  }
}
