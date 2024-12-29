import 'package:flutter/material.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arrière-plan image couvrant tout l'écran
          Positioned.fill(
            child: Image.asset(
              'assets/images.jpeg', // Assurez-vous que ce fichier existe
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
                      'Créer un compte',
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
                        labelText: 'Nom complet',
                        prefixIcon: Icon(Icons.person, color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Confirmer le mot de passe',
                        prefixIcon: Icon(Icons.lock, color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Bouton "Créer un compte"
                    GestureDetector(
                      onTap: () {
                        // Action à effectuer lors de la création d'un compte
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
                    const SizedBox(height: 15),
                    // Bouton "Retour à la connexion"
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(colors: [
                            Colors.grey,
                            Colors.black45,
                          ]),
                        ),
                        child: const Center(
                          child: Text(
                            'Retour',
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
