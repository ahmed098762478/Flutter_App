import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final dbHelper = DatabaseHelper();
    final userList = await dbHelper.getAllUsers();
    setState(() {
      users = userList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Liste des utilisateurs'),
      ),
      body: users.isEmpty
          ? const Center(
              child: Text(
                "Aucun utilisateur trouvé.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: const Icon(Icons.person, color: Colors.blue),
                    title: Text(user['fullName']),
                    subtitle: Text(user['email']),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
            ),
    );
  }
}
