import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housing/ui/res/colors.dart';

import 'sizes.dart';

/// Тема приложения

final mainTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
//  backgroundColor: primaryBackgroundColor,
  textSelectionTheme: TextSelectionThemeData(cursorColor: basicBlue),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: basicBlue)),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.white,
      backgroundColor: basicBlue,
      minimumSize: Size.fromHeight(heightOfButtonsAndTextFields),
    ),
  ),
);
