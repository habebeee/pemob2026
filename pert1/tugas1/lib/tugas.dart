import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kartu Perkenalan',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text(
            'Kartu Perkenalan',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.person,
                size: 80,
                color: Colors.red,
              ),
              SizedBox(height: 16),
              Text(
                'Nama: [Habiburrahman]',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'NIM: [20240801149]',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Jurusan: [JURUSAN]',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Hobi: [Main layangan]',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}