import "package:flutter/material.dart";

abstract interface class AppThemeData {
  ThemeData get light => ThemeData.light();
  ThemeData get dark => ThemeData.dark();
}

class AppTheme implements AppThemeData {
  @override
  ThemeData get dark => ThemeData(colorScheme: const ColorScheme.dark());

  @override
  ThemeData get light => ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 235, 235, 235),
      onPrimary: Color.fromARGB(255, 47, 62, 70),
      secondary: Color.fromARGB(255, 82, 121, 111),
      shadow: Color.fromARGB(100, 0, 0, 0),
      error: Color.fromARGB(255, 88, 32, 33),
    ),
    textTheme: _textTheme,
  );

  static const _textTheme = TextTheme(
    titleLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
  );
}

extension AppThemeX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
