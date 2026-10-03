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
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.face,
                  size: 80,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Habiburrahman Ikwan',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.red,
                ),
              ),
              Text(
                'NIM: 20240801149',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
              Text(
                'Jurusan: Teknik Informatika',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
              Text(
                'Hobi: Main Layangan',
                style: TextStyle(
                  fontSize: 18,
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