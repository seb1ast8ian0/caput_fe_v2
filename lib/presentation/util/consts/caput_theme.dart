import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/material.dart';


class CaputTheme{

  static Color bright = const Color.fromARGB(255, 254, 254, 254);

  static ThemeData lightTheme = ThemeData(

    brightness: Brightness.light,

    dialogBackgroundColor: const Color.fromARGB(179, 240, 240, 240),

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
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: CaputColors.colorTextPrimaryLight
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: CaputColors.colorTextSecondaryLight
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: CaputColors.colorBlue
      )
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: CaputColors.colorLightGrey.withOpacity(0.6)
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: bright,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: bright,
    ),
    scaffoldBackgroundColor: bright,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color.fromARGB(179, 240, 240, 240),
      hintStyle: const TextStyle(
        color:Colors.black45,
        fontSize: 16
      ),
      border: OutlineInputBorder(
        borderSide:  BorderSide(
          color: CaputColors.colorLightGrey.withOpacity(0.4),
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
    ),

    //für Tag Widget!
    chipTheme: ChipThemeData(
      backgroundColor: CaputColors.colorLightGrey.withOpacity(0.2),
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.black45,
      )
    ),

    timePickerTheme: TimePickerThemeData(
      backgroundColor: CaputColors.colorBackgroundLight,
      helpTextStyle: const TextStyle(
        fontSize: 16
      ),
    )
  );

  static Color dark = const Color.fromARGB(255, 14, 14, 14);

  static ThemeData darkTheme = ThemeData(

    brightness: Brightness.dark,

    dialogBackgroundColor: const Color.fromRGBO(34, 34, 34, 1),

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

    //für Tag Widget!
    chipTheme: ChipThemeData(
      backgroundColor: Colors.white10,
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      )
    ),
    
    textTheme: const TextTheme(
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: CaputColors.colorTextPrimaryDark
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: CaputColors.colorTextSecondaryLight
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: CaputColors.colorBlue
      )
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: CaputColors.colorLightGrey.withOpacity(0.3)
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: dark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: dark,
    ),
    scaffoldBackgroundColor:dark,
    inputDecorationTheme: InputDecorationTheme(
      fillColor:Colors.white10,
      hintStyle: const TextStyle(
        color: Colors.white70,
        fontSize: 16
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

