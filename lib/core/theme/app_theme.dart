// Flutter imports:
import 'package:flutter/material.dart';

class ThemeColors {
  static const Color clrTransparent = Color(0x00ffffff);
  static const Color clrBlack = Color(0xFF000000);
  static const Color clrGreen = Color(0xFF4CAF50);
  static const Color clrBlack50 = Color(0xFF181818);
  static const Color clrWhite = Color(0xFFFFFFFF);
  static const Color clrGrey = Color(0xFF919191);
  static const Color clrProfileSettingsTelegramColor = Color(0xFF25B5E2);
  static const Color clrProfileSettingsFacebookColor = Color(0xFF4276D7);
  static const Color clrBorderColor = Color(0xFFD5D0FF);
  static const Color clrPrimaryColor20 = Color(0xFFD5D0FF);
  static const Color darkAppColor = Color(0xFF0D0E25);

  static const Color primaryColor = Color(0xFFB0BEC5);
  static const Color secondaryColor = Color(0xFF90A4AE);

  // Added Flutter Material Colors
  static const Color deepPurple = Color(0xFF673AB7);
  static const Color deepPurple50 = Color(0xFFEDE7F6);
  static const Color deepPurple100 = Color(0xFFD1C4E9);
  static const Color pink = Color(0xFFE91E63);
  static const Color blue = Color(0xFF2196F3);
  static const Color red = Color(0xFFF44336);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey600 = Color(0xFF757575);
  static const Color white = Color(0xFFFFFFFF);
  static const Color white70 = Color(0xB3FFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color orange = Color(0xFFFF9800);
  static const Color purple = Color(0xFF9C27B0);
  static const Color yellow = Color(0xFFFFEB3B);
  static const Color cyan = Color(0xFF00BCD4);
  static const Color lime = Color(0xFFCDDC39);
  static const Color indigo = Color(0xFF3F51B5);
  static const Color teal = Color(0xFF009688);
  static const Color amber = Color(0xFFFFC107);
  static const Color brown = Color(0xFF795548);
  static const Color blueGrey = Color(0xFF607D8B);
  static const Color redAccent = Color(0xFFFF5252);
  static const Color greenAccent = Color(0xFF69F0AE);
  static const Color blueAccent = Color(0xFF448AFF);
  static const Color orangeAccent = Color(0xFFFFAB40);
  static const Color purpleAccent = Color(0xFFE040FB);
  static const Color yellowAccent = Color(0xFFFFFF00);
  static const Color pinkAccent = Color(0xFFFF4081);
  static const Color cyanAccent = Color(0xFF18FFFF);
  static const Color limeAccent = Color(0xFFEEFF41);
  static const Color indigoAccent = Color(0xFF536DFE);
  static const Color tealAccent = Color(0xFF64FFDA);
}

List<Color> getColorList() {
  return [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.pink,
    Colors.cyan,
    Colors.lime,
    Colors.indigo,
    Colors.teal,
    Colors.amber,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.redAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.purpleAccent,
    Colors.yellowAccent,
    Colors.pinkAccent,
    Colors.cyanAccent,
    Colors.limeAccent,
    Colors.indigoAccent,
    Colors.tealAccent,
  ].map((color) => color).toList();
}

class ThemeFonts {
  static const String lexend = "Lexend";
  static const String lexendDeca = "LexendDeca";
  static const String urbanist = "Urbanist";
}

class AppTheme {
  AppBarTheme appBarTheme() => const AppBarTheme(
        backgroundColor: ThemeColors.clrWhite,
        surfaceTintColor: ThemeColors.clrWhite,
        foregroundColor: ThemeColors.clrBlack,
        elevation: 2,
      );

  static TextTheme textTheme(BuildContext context) {
    final currentTextTheme = Theme.of(context).textTheme;
    const defaultTextColor = ThemeColors.clrBlack;
    const lexend = ThemeFonts.lexend;
    return TextTheme(
      headlineMedium: currentTextTheme.headlineMedium!.copyWith(
        color: defaultTextColor,
        fontFamily: lexend,
        fontSize: 32,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: currentTextTheme.titleLarge!.copyWith(
        color: defaultTextColor,
        fontFamily: lexend,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: currentTextTheme.titleMedium!.copyWith(
          color: defaultTextColor,
          fontFamily: lexend,
          fontWeight: FontWeight.w500),
      titleSmall: currentTextTheme.titleSmall!.copyWith(
          color: defaultTextColor,
          fontFamily: lexend,
          fontWeight: FontWeight.w400,
          fontSize: 16),
      displayLarge:
          currentTextTheme.displayLarge!.copyWith(color: defaultTextColor),
      displayMedium:
          currentTextTheme.displayMedium!.copyWith(color: defaultTextColor),
      displaySmall:
          currentTextTheme.displaySmall!.copyWith(color: defaultTextColor),
      headlineSmall:
          currentTextTheme.headlineSmall!.copyWith(color: defaultTextColor),
      labelMedium:
          currentTextTheme.titleLarge!.copyWith(color: defaultTextColor),
      bodyLarge: currentTextTheme.bodyLarge!.copyWith(color: defaultTextColor),
      bodyMedium:
          currentTextTheme.bodyMedium!.copyWith(color: defaultTextColor),
      labelLarge:
          currentTextTheme.labelLarge!.copyWith(color: defaultTextColor),
      bodySmall: currentTextTheme.bodySmall!.copyWith(color: defaultTextColor),
      labelSmall:
          currentTextTheme.labelSmall!.copyWith(color: defaultTextColor),
    );
  }

  /// Theme data for Material and Elevated button
  static ElevatedButtonThemeData elevatedButtonThemeData() =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          // foregroundColor: ThemeColors.clrWhite,
          backgroundColor: ThemeColors.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
}

class AppThemeDark {
  static AppBarTheme appBarTheme() {
    return const AppBarTheme(
      backgroundColor: ThemeColors.clrBlack,
      foregroundColor: ThemeColors.clrWhite,
      titleTextStyle: TextStyle(color: ThemeColors.clrWhite),
    );
  }

  static ElevatedButtonThemeData elevatedButtonThemeData() =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: ThemeColors.clrWhite,
          backgroundColor: ThemeColors.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
}

ThemeData lightTheme(BuildContext context) => ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      primaryColor: ThemeColors.primaryColor,
      primaryColorDark: ThemeColors.clrBlack50,
      scaffoldBackgroundColor: ThemeColors.clrWhite,
      appBarTheme: AppTheme().appBarTheme(),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ThemeColors.primaryColor,
        selectionColor: ThemeColors.primaryColor.withOpacity(0.4),
        selectionHandleColor: ThemeColors.primaryColor,
      ),
      useMaterial3: true,
      focusColor: ThemeColors.primaryColor,
      fontFamily: ThemeFonts.lexend,
      elevatedButtonTheme: AppTheme.elevatedButtonThemeData(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: ThemeColors.clrBlack,
      ),
    );

ThemeData darkTheme(BuildContext context) => ThemeData(
      colorSchemeSeed: ThemeColors.primaryColor,
      scaffoldBackgroundColor: ThemeColors.clrBlack,
      brightness: Brightness.dark,
      useMaterial3: true,
      appBarTheme: AppThemeDark.appBarTheme(),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: ThemeColors.primaryColor,
        selectionColor: ThemeColors.primaryColor,
        selectionHandleColor: ThemeColors.primaryColor,
      ),
      focusColor: ThemeColors.primaryColor,
      elevatedButtonTheme: AppThemeDark.elevatedButtonThemeData(),
      fontFamily: ThemeFonts.lexend,
    );
