import 'package:flutter/material.dart';

class DisponibleScreen extends StatelessWidget {
  final DateTime startTime;
  final DateTime currentTime;

  DisponibleScreen({required this.startTime, required this.currentTime});

  @override
  Widget build(BuildContext context) {
    bool isAvailable = currentTime.isBefore(startTime);

    return Scaffold(
      appBar: AppBar(
        title: Text('Disponibilité'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isAvailable ? Colors.green : Colors.red,
              ),
              child: Icon(
                isAvailable ? Icons.check : Icons.close,
                size: 80,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              isAvailable ? "La salle est disponible" : "La salle n'est pas disponible",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
