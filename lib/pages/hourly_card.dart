import 'package:flutter/material.dart';

class HourlyCard extends StatelessWidget {
  final String time;
  final String tempreature;
  final IconData icon;
  const HourlyCard(
      {super.key,
      required this.time,
      required this.tempreature,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              icon,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              tempreature,
            ),
          ],
        ),
      ),
    );
  }
}
