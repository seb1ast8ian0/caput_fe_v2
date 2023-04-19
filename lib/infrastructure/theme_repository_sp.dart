import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository{

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  setTheme(ThemeMode themeMode) async{
    final SharedPreferences prefs = await _prefs;
    prefs.setString("themeMode", themeMode.toString());
  }

  Future<ThemeMode> getTheme() async{
    final SharedPreferences prefs = await _prefs;
    var mode = prefs.getString("themeMode")?? "error";
    if(mode == "ThemeMode.dark"){
      return ThemeMode.dark;
    } else if (mode == "ThemeMode.light"){
      return ThemeMode.light;
    } else{
      return ThemeMode.system;
    } 
  }

}