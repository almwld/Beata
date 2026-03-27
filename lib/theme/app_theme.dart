import 'package:flutter/material.dart';

class AppTheme {
  static const Color goldColor = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFF4D03F);
  static const Color goldPrimary = Color(0xFFC6A700);
  static const Color error = Color(0xFFE74C3C);
  static const Color success = Color(0xFF2ECC71);
  static const Color info = Color(0xFF3498DB);
  static const Color warning = Color(0xFFF39C12);
  
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF121212);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color darkCard = Color(0xFF2C2C2C);
  static const Color lightCard = Color(0xFFFAFAFA);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkTextLight = Color(0xFFE0E0E0);
  static const Color lightText = Color(0xFF000000);
  static const Color darkTextSecondary = Color(0xFFAAAAAA);
  static const Color lightTextSecondary = Color(0xFF666666);
  static const Color darkDivider = Color(0xFF3C3C3C);
  static const Color lightDivider = Color(0xFFE0E0E0);

  static const LinearGradient goldGradient = LinearGradient(
    colors: [goldColor, goldLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: goldColor,
      scaffoldBackgroundColor: lightBackground,
      cardColor: lightCard,
      appBarTheme: const AppBarTheme(
        backgroundColor: lightSurface,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: goldColor,
      scaffoldBackgroundColor: darkBackground,
      cardColor: darkCard,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }

  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? darkText : lightText;
  }

  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? darkTextSecondary : lightTextSecondary;
  }

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? darkBackground : lightBackground;
  }

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? darkCard : lightCard;
  }

  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? darkSurface : lightSurface;
  }

  static Color getDividerColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? darkDivider : lightDivider;
  }
}
