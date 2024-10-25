import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenderPredictionScreen extends StatefulWidget {
  const GenderPredictionScreen({super.key});

  @override
  _GenderPredictionScreenState createState() => _GenderPredictionScreenState();
}

class _GenderPredictionScreenState extends State<GenderPredictionScreen> {
  String name = '';
  String gender = '';
  bool isLoading = false;

  Future<void> predictGender(String name) async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        gender = data['gender'] == 'male' ? 'Masculino' : 'Femenino';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predecir Género'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Ingresa tu nombre'),
              onChanged: (value) {
                name = value;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => predictGender(name),
              child: const Text('Predecir Género'),
            ),
            if (isLoading)
              const CircularProgressIndicator(),
            if (gender.isNotEmpty)
              Container(
                color: gender == 'Masculino' ? Colors.blue : Colors.pink,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Género: $gender',
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
