import 'package:flutter/material.dart';

abstract class ThemeRepository{

  Future<void> setTheme(ThemeMode themeMode);

  Future<ThemeMode> getTheme();

}