import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/sizes.dart';

/// Тема приложения

final mainTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.white,
  accentColor: basicBlue,
  textSelectionTheme: TextSelectionThemeData(cursorColor: basicBlue),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: basicBlue)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.white,
      backgroundColor: basicBlue,
      minimumSize: Size.fromHeight(heightOfButtonsAndTextFields),
    ),
  ),
);
