import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 1.2),
    borderRadius: BorderRadius.circular(10),
  );
static final darkThemeMode = ThemeData.light().copyWith(    scaffoldBackgroundColor: AppPallete.backgroundColor,
appBarTheme: AppBarTheme(
  backgroundColor: AppPallete.backgroundColor,
  foregroundColor: AppPallete.textColor,
  elevation: 0,
),    chipTheme: ChipThemeData(
      color: WidgetStatePropertyAll(AppPallete.backgroundColor),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
  filled: true,
  fillColor: AppPallete.surfaceColor,

  contentPadding: const EdgeInsets.symmetric(
    horizontal: 18,
    vertical: 17,
  ),

  hintStyle: const TextStyle(
    color: AppPallete.greyColor,
    fontSize: 14,
  ),

  border: _border(),
  enabledBorder: _border(),
  focusedBorder: _border(AppPallete.gradient3),
  errorBorder: _border(AppPallete.errorColor),
  focusedErrorBorder: _border(AppPallete.errorColor),
),
  );

  static ThemeData? get lightThemeMode => null;
}
