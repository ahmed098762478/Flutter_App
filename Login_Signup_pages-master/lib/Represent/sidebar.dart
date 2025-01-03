import 'package:flutter/material.dart';
import 'package:untitled3/Represent/UserScreen.dart';
import '../loginScreen.dart';
import 'CryptoChartScreen.dart';
import 'Profile.dart'; 
import 'Settings.dart';  
import '../helpers/database_helper.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  String userEmail = "Chargement...";

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
  final dbHelper = DatabaseHelper();
  final currentUser = await dbHelper.getCurrentUser();
  if (currentUser != null) {
    setState(() {
      userEmail = currentUser['email'];
    });
  } else {
    setState(() {
      userEmail = "Aucun utilisateur trouvé";
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 72, 80, 111),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/admin.png'),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'En ligne',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userEmail,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
  leading: const Icon(Icons.local_hospital),
  title: const Text('Utilisateurs'),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserScreen()),
    );
  },
),

          ListTile(
            leading: const Icon(Icons.currency_bitcoin),
            title: const Text('Crypto'),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CryptoChartScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Paramètre'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Déconnexion'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const loginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
