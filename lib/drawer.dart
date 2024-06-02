import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wZlot/contact_page.dart';
import 'package:wZlot/about_us_page.dart';
//import 'package:wZlot/map_page.dart';
import 'package:wZlot/timetable_page.dart';
import 'package:wZlot/registration_page.dart';
import 'package:wZlot/login_page.dart';
import 'package:wZlot/share_page.dart';
//import 'package:wZlot/teams_page.dart';
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
    User? user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              //padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(
                height: 64,
                child: SizedBox(
                  height: 64,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                    ),
                    child: Row(
                      children: [
                        new SvgPicture.asset(
                          r'icons\logo.svg',
                          height: 50.0,
                          width: 50.0,
                          allowDrawingOutsideViewBox: true,
                        ),
                        
                        SizedBox(width: 10), // Margines między ikoną a tekstem
                        Text(
                          'Menu',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),),
                ListTile(
                  title: const Text('Strona główna'),
                  onTap: () {
                    navigateWithAnimation(context, const MyHomePage(title: "Strona główna"));
                  },
                ),
                ListTile(
                  title: const Text('O nas'),
                  onTap: () {
                    navigateWithAnimation(context, const HistoryPage());
                  },
                ),
                ListTile(
                  title: const Text('Kontakt'),
                  onTap: () {
                    navigateWithAnimation(context, const ContactPage());
                  },
                ),
                /*ListTile(
                  title: const Text('Mapa wydarzenia'),
                  onTap: () {
                    navigateWithAnimation(context, const MapPage());
                  },
                ),*/
                ListTile(
                  title: const Text('Harmonogram atrakcji'),
                  onTap: () {
                    navigateWithAnimation(context, const TimetablePage());
                  },
                ),
                ListTile(
                  title: const Text('Twoje zajęcia'),
                  onTap: () {
                    navigateWithAnimation(context, const RegistrationPage());
                  },
                ),
                /*ListTile(
                  title: const Text('Poznaj inne drużyny'),
                  onTap: () {
                    navigateWithAnimation(context, const TeamsPage());
                  },
                ),*/
                ListTile(
                  title: const Text('Pochwal się znajomym!'),
                  onTap: () {
                    navigateWithAnimation(context, const SharePage());
                  },
                ),
              ],
            ),
          ),
          if (user == null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  navigateWithAnimation(context, const LoginPage());
                },
                child: const Text('Zaloguj się'),
              ),
            ),
          if (user != null)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Użytkownik: ${user.email}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const MyHomePage(title: 'wZlot')),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text('Wyloguj się'),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
