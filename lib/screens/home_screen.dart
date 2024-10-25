import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toolbox App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image.asset('assets/toolbox.png'), // Imagen de la caja de herramientas
            // const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/gender');
              },
              child: const Text('Predecir Género'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/age');
              },
              child: const Text('Predecir Edad'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/universities');
              },
              child: const Text('Universidades por País'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/about');
              },
              child: const Text('Acerca de mí'),
            ),
          ],
        ),
      ),
    );
  }
}
