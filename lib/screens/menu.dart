import 'package:flutter/material.dart';
import '../widgets/left_drawer.dart';
import 'newslist_form.dart'; 
import '../widgets/news_card.dart';


class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String nama = "Haru Urara"; // Name
  final String npm = "2406275678";  // NPM
  final String kelas = "KKI";       // Class

  final List<ItemHomepage> items = const [
    ItemHomepage("See Football News", Icons.newspaper, route: '/news'),
    ItemHomepage("Add News", Icons.add, route: '/add-news'),
    ItemHomepage("Logout", Icons.logout, route: '/logout'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Football News',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const LeftDrawer(), // Drawer
      body: SafeArea(
        child: SingleChildScrollView( // prevent overflow on small screens
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Row for 3 InfoCard horizontally
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(title: 'NPM', content: npm),
                  InfoCard(title: 'Name', content: nama),
                  InfoCard(title: 'Class', content: kelas),
                ],
              ),

              const SizedBox(height: 16.0),

              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Selamat datang di Football News',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Grid for item cards
              GridView.count(
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: items.map((ItemHomepage item) {
                  return ItemCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// InfoCard: simple card showing title & content
class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final String? route;

  const ItemHomepage(this.name, this.icon, {this.route});
}


