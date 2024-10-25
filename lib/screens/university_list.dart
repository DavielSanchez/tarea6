import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class UniversitiesScreen extends StatefulWidget {
  const UniversitiesScreen({super.key});

  @override
  _UniversitiesScreenState createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  String _country = '';
  List _universities = [];

  Future<void> fetchUniversities(String country) async {
    final url = 'http://universities.hipolabs.com/search?country=$country';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        _universities = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Universidades')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Ingrese el país'),
              onChanged: (value) {
                _country = value;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => fetchUniversities(_country),
              child: const Text('Buscar Universidades'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _universities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_universities[index]['name']),
                    subtitle: Text(_universities[index]['domains'].join(', ')),
                    trailing: IconButton(
                      icon: const Icon(Icons.link),
                      onPressed: () async {
                        final url = _universities[index]['web_pages'][0];
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          throw 'No se pudo abrir el enlace $url';
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
