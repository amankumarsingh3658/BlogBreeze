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
    chipTheme: ChipThemeData(
        color: WidgetStatePropertyAll(
          AppPallete.backgroundColor,
        ),
        side: BorderSide.none),
    appBarTheme:
        const AppBarTheme(backgroundColor: AppPallete.transparentColor),
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
        border: _border(),
        contentPadding: const EdgeInsets.all(27),
        enabledBorder: _border(),
        errorBorder: _border(AppPallete.errorColor),
        focusedBorder: _border(AppPallete.gradient2)),
  );
}
