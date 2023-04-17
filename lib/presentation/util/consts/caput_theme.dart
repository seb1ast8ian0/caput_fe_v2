import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      textTheme: TextTheme(
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isDarkTheme ? Colors.white : Colors.black
        ),
        bodyMedium: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: CaputColors.colorTextSecondaryLight
        )
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: isDarkTheme ? CaputColors.colorLightGrey.withOpacity(0.3) : CaputColors.colorLightGrey.withOpacity(0.6)
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: isDarkTheme ? const Color.fromRGBO(34, 34, 34, 1) : const Color.fromRGBO(221, 221, 221, 1),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkTheme ? const Color.fromRGBO(34, 34, 34, 1) : const Color.fromRGBO(221, 221, 221, 1),
      ),
      scaffoldBackgroundColor: isDarkTheme ? CaputColors.colorBackgroundDark : CaputColors.colorBackgroundLight,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: isDarkTheme ? Colors.white24 : Colors.white70,
        hintStyle: TextStyle(
          color: isDarkTheme ? Colors.white70 : Colors.black45,
          fontSize: 14
        ),
        border: OutlineInputBorder(
          borderSide:  BorderSide(
            color: CaputColors.colorLightGrey.withOpacity(0.2),
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}