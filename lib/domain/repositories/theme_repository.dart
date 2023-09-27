import 'package:flutter/material.dart';

abstract class ThemeRepository{

  //TODO void>

  Future<void> setTheme(ThemeMode themeMode);

  Future<ThemeMode> getTheme();

}