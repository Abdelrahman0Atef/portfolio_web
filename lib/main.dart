import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'core/theme/app_theme.dart';
import 'screens/portfolio_page.dart';

void main() {
  // visibility_detector emits warnings about its update interval — silence
  // them and tighten the firing rate for snappier reveal animations.
  VisibilityDetectorController.instance.updateInterval =
      const Duration(milliseconds: 80);

  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abdelrahman Atef · Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      // Force dark — the curated experience.
      themeMode: ThemeMode.dark,
      home: const PortfolioPage(),
    );
  }
}
