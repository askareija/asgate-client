import 'package:asgate/home_page.dart';
import 'package:asgate/onboarding_page.dart';
import 'package:asgate/utils/custom_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASGate',
      themeMode: ThemeMode.system,
      theme: customLightTheme(context),
      darkTheme: customDarkTheme(context),
      home: const OnboardingPage(),
    );
  }
}
