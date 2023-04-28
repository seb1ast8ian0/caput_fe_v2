import 'package:Caput/main.dart';
import 'package:Caput/presentation/screens/main_screen/main_screen.dart';
import 'package:Caput/presentation/screens/test_screen.dart';
import 'package:Caput/presentation/states/neuron_state.dart';
import 'package:Caput/presentation/states/theme_state.dart';
import 'package:Caput/presentation/util/consts/caput_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class Caput extends StatelessWidget{

  Caput({super.key});

  final neuronState = getIt.get<NeuronState>();

  @override
  Widget build(BuildContext context){

    neuronState.invoke();

    return MaterialApp(
      title: 'Caput',
      locale: const Locale('de'),
      theme: CaputTheme.lightTheme,
      darkTheme: CaputTheme.darkTheme,
      themeMode: context.watch<ThemeState>().themeMode,
      home: const MainScreen(),
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: const[
        Locale('en'), // English
        Locale('de'), // Deutsch
      ],
    );

  }
  
}