import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        );
  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(23),
        enabledBorder: _border(), // border will be seen before clicking
        focusedBorder: _border(AppPallete.gradient3 ),  // border will be seen after clicked
      )
  );
}