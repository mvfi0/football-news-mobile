import 'package:flutter/material.dart';
import 'package:football_news/screens/newsentry_form.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

// IMORTANT: Check these file names match your project exactly  
import '../screens/news_entry_list.dart';
import '../screens/login.dart';
import '../screens/menu.dart'; // Assuming ItemHomepage is defined here

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Material(
      // Use shape to apply rounded corners to the Material
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Theme.of(context).colorScheme.secondary,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          // 1. Show the default SnackBar
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!")),
            );

          // 2. Handle "Add News"
          if (item.name == "Add News") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewsFormPage()),
            );
          } 
          // 3. Handle "See Football News"
          else if (item.name == "See Football News") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewsEntryListPage(),
              ),
            );
          }
          // 4. Handle "Logout" (With Async Logic)
          else if (item.name == "Logout") {
            // TODO: Change localhost to 10.0.2.2 if using Android Emulator
            final response = await request.logout(
                "http://localhost:8000/auth/logout/");
            
            String message = response["message"];
            
            if (context.mounted) {
              if (response['status']) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message Sampai jumpa, $uname."),
                ));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              }
            }
          }
          // 5. Handle generic routing (only if none of the above matched)
          // We check 'item.route != null' just in case
          else if (item.route != null) {
            Navigator.of(context).pushNamed(item.route!);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}