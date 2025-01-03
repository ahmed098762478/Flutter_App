import 'package:flutter/material.dart';
import 'loginScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 114, 94, 174),
              Color(0x00c7cad0),
            ],
          ),
        ),
        child: Column(
          children: [
            const Padding(
              padding:
                  EdgeInsets.only(top: 50),  
              child: Image(
                image: AssetImage('assets/Logos.png'),
                height: 300, 
                width: 300, 
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            const Text(
              'SOYER LE BIENVENUE',
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const loginScreen()),
                );
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black),
                ),
                child: const Center(
                  child: Text(
                    'se connecter',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Text(
              'Se connecter avec les réseaux sociaux',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
