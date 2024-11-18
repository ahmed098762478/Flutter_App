import 'package:flutter/material.dart';

import 'loginScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFF2FCB85),
          Color(0x0c7cad0),
        ])),
        child: Column(children: [
          const Padding(
  padding: EdgeInsets.only(top: 200.0),
  child: Image(
    image: AssetImage('assets/logo.webp'),
    height: 200,  
    width: 200,   
    fit: BoxFit.contain, 
  ),
),

          const SizedBox(
            height: 100,
          ),
          const Text(
            'SOYER LE BIENVENUE',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const loginScreen()));
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
                      color: Colors.white),
                ),
              ),
            ),
          ),
          const Spacer(),
          const Text(
            'Login with Social Media',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
          const SizedBox(
            height: 12,
          ),
          
        ]),
      ),
    );
  }
}
