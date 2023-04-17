import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      animationDuration: const Duration(milliseconds: 50),
      overlayColor: MaterialStateProperty.resolveWith((states) {return Colors.transparent;}),
      iconColor: MaterialStateProperty.resolveWith((states) {return states.contains(MaterialState.pressed) ?  CaputColors.colorBlue.withOpacity(0.6) : CaputColors.colorBlue;}),
      foregroundColor: MaterialStateProperty.resolveWith((states) {return states.contains(MaterialState.pressed) ?  CaputColors.colorBlue.withOpacity(0.6) : CaputColors.colorBlue;}),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minimumSize: MaterialStateProperty.all(Size.zero),
      
    )
  ),
  
  textTheme: const TextTheme(
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: CaputColors.colorTextPrimaryLight
    ),
    bodyMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: CaputColors.colorTextSecondaryLight
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: CaputColors.colorBlue
    )
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: CaputColors.colorLightGrey.withOpacity(0.6)
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color.fromRGBO(221, 221, 221, 1),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(221, 221, 221, 1),
  ),
  scaffoldBackgroundColor: CaputColors.colorBackgroundLight,
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white70,
    hintStyle: const TextStyle(
      color:Colors.black45,
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

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      animationDuration: const Duration(milliseconds: 50),
      overlayColor: MaterialStateProperty.resolveWith((states) {return Colors.transparent;}),
      iconColor: MaterialStateProperty.resolveWith((states) {return states.contains(MaterialState.pressed) ?  CaputColors.colorBlue.withOpacity(0.6) : CaputColors.colorBlue;}),
      foregroundColor: MaterialStateProperty.resolveWith((states) {return states.contains(MaterialState.pressed) ?  CaputColors.colorBlue.withOpacity(0.6) : CaputColors.colorBlue;}),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minimumSize: MaterialStateProperty.all(Size.zero),
      
    )
  ),
  
  textTheme: const TextTheme(
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: CaputColors.colorTextPrimaryDark
    ),
    bodyMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: CaputColors.colorTextSecondaryLight
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: CaputColors.colorBlue
    )
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: CaputColors.colorLightGrey.withOpacity(0.3)
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color.fromRGBO(34, 34, 34, 1),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(34, 34, 34, 1),
  ),
  scaffoldBackgroundColor:CaputColors.colorBackgroundDark,
  inputDecorationTheme: InputDecorationTheme(
    fillColor:Colors.white24,
    hintStyle: const TextStyle(
      color: Colors.white70,
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