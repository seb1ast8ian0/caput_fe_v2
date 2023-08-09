import 'package:Caput/domain/repositories/theme_repository.dart';
import 'package:Caput/infrastructure/repositories/shared_preferences/theme_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeState extends ChangeNotifier with DiagnosticableTreeMixin{

  ThemeMode _themeMode = ThemeMode.system;

  get themeMode => _themeMode;

  ThemeState(){
    ThemeRepository repo = ThemeRepositoryImpl();
    repo.getTheme().then((value) {
      _themeMode = value;
      notifyListeners();
    });
  }


  setTheme(ThemeMode themeMode) async{
    ThemeRepository repo = ThemeRepositoryImpl();
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