import 'package:agropal/theme/themes.dart';
import 'package:flutter/material.dart';

class MainElevatedButton extends StatelessWidget {
  late final VoidCallback? onPressed;
  late final Widget? child;

  MainElevatedButton({required this.onPressed, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      child: ElevatedButton(onPressed: onPressed, child: child),
    );
  }
}
