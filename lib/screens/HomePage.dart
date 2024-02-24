import 'package:flutter/material.dart';
import 'package:cmms/components/drawer_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Color blanco para el app bar
        elevation: 0, // Sin sombra en el app bar
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Text(
                'WELCOME',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: DrawerMenu(
        onItemTapped: (index) {
          Navigator.pop(context);
        },
        parentContext: context,
      ),
    );
  }
}
