import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wZlot/app_bar.dart';
import 'package:wZlot/drawer.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "Skontaktuj się z nami"),
      drawer: MainDrawer(),
      body: Column(
        
        children: [
          Padding(padding: EdgeInsets.all(10.0),
            child: Column(
            children: [
              const Text(
                    'Jeżeli masz jakiekolwiek pytania do organizatorów, napisz do nas na maila lub poprzez fanpage na facebooku.',
                    
                    style: TextStyle(fontSize: 16),
                  ),
              const SizedBox(height: 20),
              const Text(
                    'W pilnych sprawach skontaktuj się z biurem wZlotowym pod podanym numerem.',
                    style: TextStyle(fontSize: 16),
                  ),
              const SizedBox(height: 20),
              const Text(
                    'Zanim napiszesz maila, zerknij do naszego FAQ.',
                    style: TextStyle(fontSize: 16),
                  ),
            ],
          ),
          ),
          
          _buildContactRow(
            icon: Icons.phone,
            text: "+48 693 543 717",
            onPressed: () => _launchURL('tel:+48693543717'),
          ),
          _buildContactRow(
            icon: Icons.email,
            text: "wzlot@zhp.wlkp.pl",
            onPressed: () => _launchURL('mailto:wzlot@zhp.wlkp.pl'),
          ),
          _buildContactRow(
            icon: Icons.question_answer,
            text: "Strona FAQ",
            onPressed: () => _launchURL('http://wzlot.zhp.pl/faq/'),
          ),
          _buildContactRow(
            icon: Icons.facebook,
            text: "Fanpage na Facebooku",
            onPressed: () => _launchFbPage('https://www.facebook.com/wZlot'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          IconButton(
            icon: Icon(icon),
            onPressed: onPressed,
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

    Future<void> _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchFbPage(String url) async {
    final fbUrl = 'fb://facewebmodal/f?href=$url';
    if (await canLaunchUrlString(fbUrl)) {
      await launchUrlString(fbUrl);
    } else {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
