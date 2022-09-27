import 'package:agropal/theme/colors.dart';
import 'package:flutter/material.dart';

Widget customDivider() {
  return Padding(
    padding: const EdgeInsets.only(right: 12, left: 12),
    child: Divider(
      color: AppColors.borderColor,
      thickness: 1,
    ),
  );
}
