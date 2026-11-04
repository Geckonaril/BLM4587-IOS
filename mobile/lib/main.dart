import 'package:flutter/material.dart';

import 'screens/calendar_screen.dart';

void main() {
  runApp(const TakvimApp());
}

class TakvimApp extends StatelessWidget {
  const TakvimApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF6655D9);

    return MaterialApp(
      title: 'Takvim+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F7FC),
        colorScheme: ColorScheme.fromSeed(seedColor: primary, primary: primary),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF6F7FC),
          foregroundColor: Color(0xFF25243A),
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
      ),
      home: const CalendarScreen(),
    );
  }
}
