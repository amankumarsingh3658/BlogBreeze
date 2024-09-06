import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 3,
        color: color,
      ));
  static final darkThemeMode = ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(backgroundColor: AppPallete.transparentColor),
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(27),
          enabledBorder: _border(),
          focusedBorder: _border(AppPallete.gradient2)));
}
