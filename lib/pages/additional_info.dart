import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  // create a constructor

  final IconData icon;
  final String value;
  final String label;

  const AdditionalInfo(
      {super.key,
      required this.icon,
      required this.value,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          value,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
