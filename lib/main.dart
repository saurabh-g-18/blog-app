import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/Presentation/pages/signup_pages.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false, //removes the debug banner 
      title: AppTheme.darkThemeMode,
      home: const SignUpPage(),
    );
  }
}     