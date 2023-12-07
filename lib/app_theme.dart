import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const _primaryColorLight = Colors.white;
  static const _primaryColorDark = Colors.black;
  static const _switchActiveColorLight = Colors.grey;
  static const _switchActiveColorDark = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
        primary: _primaryColorLight, background: _primaryColorLight),
    appBarTheme: const AppBarTheme(backgroundColor: _primaryColorLight),
    switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all<Color>(_switchActiveColorLight),
        trackOutlineColor:
            MaterialStateProperty.all<Color>(_switchActiveColorLight)),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
        primary: _primaryColorDark, background: _primaryColorDark),
    appBarTheme: const AppBarTheme(backgroundColor: _primaryColorDark),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all<Color>(_switchActiveColorDark),
      trackOutlineColor:
          MaterialStateProperty.all<Color>(_switchActiveColorDark),
    ),
  );
}
