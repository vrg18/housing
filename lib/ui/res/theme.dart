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
    style: ButtonStyle(
      minimumSize: MaterialStateProperty.resolveWith<Size>((states) => Size.fromHeight(heightOfButtonsAndTextFields)),
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => basicBlue),
      foregroundColor: MaterialStateProperty.resolveWith<Color>((states) => Colors.white),
    ),
  ),
);
