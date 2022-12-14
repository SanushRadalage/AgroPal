import 'package:agropal/theme/colors.dart';
import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  final double size;

  Headline({required this.size});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Agro",
          style: TextStyle(
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.bold,
              fontSize: size,
              color: AppColors.primary),
        ),
        Text(
          "Pal",
          style: TextStyle(
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.bold,
              fontSize: size,
              color: AppColors.secondary),
        ),
      ],
    );
  }
}
