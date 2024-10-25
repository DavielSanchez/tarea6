import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgePredictionScreen extends StatefulWidget {
  const AgePredictionScreen({super.key});

  @override
  _AgePredictionScreenState createState() => _AgePredictionScreenState();
}

class _AgePredictionScreenState extends State<AgePredictionScreen> {
  String _name = '';
  int _age = 0;
  String _category = '';
  String _imageUrl = '';

  Future<void> predictAge(String name) async {
    final url = 'https://api.agify.io/?name=$name';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _age = data['age'];
        if (_age < 18) {
          _category = 'Joven';
          _imageUrl = 'URL_IMAGEN_JOVEN';
        } else if (_age < 60) {
          _category = 'Adulto';
          _imageUrl = 'URL_IMAGEN_ADULTO';
        } else {
          _category = 'Anciano';
          _imageUrl = 'URL_IMAGEN_ANCIANO';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Predicción de Edad')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Ingrese un nombre'),
              onChanged: (value) {
                _name = value;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => predictAge(_name),
              child: const Text('Predecir Edad'),
            ),
            const SizedBox(height: 20),
            _age != 0
                ? Column(
                    children: [
                      Text('Edad: $_age'),
                      Text('Categoría: $_category'),
                      Image.network(_imageUrl),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
