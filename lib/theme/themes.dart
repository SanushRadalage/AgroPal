import 'package:agropal/theme/colors.dart';
import 'package:flutter/material.dart';

ThemeData getAppTheme() {
  return ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    buttonTheme: const ButtonThemeData(height: 50),
    fontFamily: 'SF Pro Text',
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.secondary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.secondary,
      iconTheme: IconThemeData(
        color: AppColors.primary,
      ),
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.secondary,
      ),
    ),
    textTheme: const TextTheme(
      headline2: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      headline3: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headline4: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      button: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      subtitle1: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      caption: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.grey,
      ),
    ),
  );
}
