import 'package:flutter/material.dart';
import 'Represent/dashboard.dart';
import 'Register.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arrière-plan image couvrant tout l'écran
          Positioned.fill(
            child: Image.asset(
              'assets/image.jpg', // Assurez-vous que ce fichier existe
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // Fond semi-transparent
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      'Bonjour, veuillez vous connecter',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
                    const TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email, color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Mot de passe',
                        prefixIcon: Icon(Icons.lock, color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Bouton "Se connecter"
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()),
                        );
                      },
                      child: Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(colors: [
                            Colors.blue,
                            Color.fromARGB(255, 36, 91, 193),
                          ]),
                        ),
                        child: const Center(
                          child: Text(
                            'Se connecter',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Bouton "Créer un compte"
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegScreen()),
                        );
                      },
                      child: Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(colors: [
                            Colors.blue,
                            Color.fromARGB(255, 36, 91, 193),
                          ]),
                        ),
                        child: const Center(
                          child: Text(
                            'Créer un compte',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
