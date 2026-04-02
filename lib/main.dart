import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/flashcard_viewmodel.dart';
import 'views/welcome/welcome_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FlashcardViewModel(),
      child: const FlashMindApp(),
    ),
  );
}

class FlashMindApp extends StatelessWidget {
  const FlashMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlashMind',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF5F3FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
        ),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}
