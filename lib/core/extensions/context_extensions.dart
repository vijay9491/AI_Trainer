import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colors => Theme.of(this).colorScheme;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  double responsiveWidth({
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    final width = MediaQuery.sizeOf(this).width;
    if (width >= 1200) return desktop;
    if (width >= 700) return tablet;
    return mobile;
  }
}
