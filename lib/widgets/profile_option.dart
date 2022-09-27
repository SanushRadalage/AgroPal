import 'package:flutter/material.dart';

Widget profileOptions(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.only(right: 16, left: 16, top: 8, bottom: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon),
        const SizedBox(
          width: 12,
        ),
        Text(text, style: const TextStyle(fontSize: 16))
      ],
    ),
  );
}
