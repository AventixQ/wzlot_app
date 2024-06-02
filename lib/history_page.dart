import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('O nas'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: Text(
                  '"Wyjdź w świat, zobacz, pomyśl - pomoż czyli działaj"',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Wielkopolski wZlot Wędrowników to wyjątkowa impreza, która pozwala na rozwój pasji i zdobywanie nowych doświadczeń, a także budowanie wspólnoty wielkopolskiego środowiska wędrowniczego.'
                'Idea wZlotu pozwala na łączenie w tym wydarzeniu trzech sfer rozwoju wędrowniczego – organizatorzy dbają bowiem o rozwój siły ducha, umysłu oraz ciała. '
                'Program tegorocznej edycji wZlotu będzie, poza rozwijaniem pasji, popularyzować wśród wędrowników odkrywanie nowych ścieżek kariery i rozowju.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Komenda wZlotu:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.7, // Adjust this value to control height
                ),
                itemBuilder: (context, index) {
                  return _buildMemberCard(
                    context,
                    name: _memberNames[index],
                    role: _memberRoles[index],
                    email: _memberEmails[index],
                    imageUrl: _memberImageUrls[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Znajdziesz nas również',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.facebook),
                          onPressed: () => _launchFbPage('https://www.facebook.com/wZlot'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.web_rounded),
                          onPressed: () => _launchURL('http://wzlot.zhp.pl/'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.share),
      ),
    );
  }

  static const List<String> _memberNames = [
    'hm. Marek Orłowski',
    'phm. Wojciech Oczujda',
    'phm. Maja Kozłowska',
    'phm. Zuzanna Tomaszewska',
    'phm. Rozalia Stochmiał',
  ];

  static const List<String> _memberRoles = [
    'Komendant zlotu',
    'Logistyka i organizacja',
    'Program wydarzenia',
    'Finanse i sponsoring',
    'Promocja wydarzenia',
  ];

  static const List<String> _memberEmails = [
    'marek.orlowski@zhp.net.pl',
    'wojciech.oczujda@zhp.net.pl',
    'maja.kozlowska@zhp.net.pl',
    'zuzanna.tomaszewska@zhp.net.pl',
    'rozalia.stochmial@zhp.net.pl',
  ];

  static const List<String?> _memberImageUrls = [
    'images\\marek.jpg',
    null,
    null,
    null,
    null,
    null,
  ];

  Widget _buildMemberCard(BuildContext context, {required String name, required String role, required String email, String? imageUrl}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (imageUrl != null)
              CircleAvatar(
                backgroundImage: AssetImage(imageUrl),
                radius: 30,
              )
            else
              const CircleAvatar(
                child: Icon(Icons.person),
                radius: 30,
              ),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              role,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => _launchURL('mailto:$email'),
              child: Text(
                email,
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
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
