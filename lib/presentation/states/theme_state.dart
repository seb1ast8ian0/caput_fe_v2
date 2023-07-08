import 'package:Caput/infrastructure/v1%20(hive)/theme_repository_sp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeState extends ChangeNotifier with DiagnosticableTreeMixin{

  ThemeMode _themeMode = ThemeMode.system;

  get themeMode => _themeMode;

  ThemeState(){
    ThemeRepository repo = ThemeRepository();
    repo.getTheme().then((value) {
      _themeMode = value;
      notifyListeners();
    });
  }


  setTheme(ThemeMode themeMode) async{
    ThemeRepository repo = ThemeRepository();
    repo.setTheme(themeMode);
    _themeMode = themeMode;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty("themeMode", _themeMode.toString()));
  }



}