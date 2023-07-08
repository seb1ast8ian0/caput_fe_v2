import 'package:Caput/main.dart';
import 'package:Caput/presentation/screens/main_screen/main_screen.dart';
import 'package:Caput/presentation/screens/test_screen.dart';
import 'package:Caput/presentation/states/neuron_state.dart';
import 'package:Caput/presentation/states/theme_state.dart';
import 'package:Caput/presentation/util/consts/caput_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class Caput extends StatefulWidget{

  Caput({super.key});

  @override
  State<Caput> createState() => _CaputState();
}

class _CaputState extends State<Caput> {

  final neuronState = getIt.get<NeuronState>();

  @override
  void initState() {
    neuronState.invoke();
    super.initState();
  }

  @override
  void dispose() {
    neuronState.cleanUp();
    super.dispose();
  }


  @override
  Widget build(BuildContext context){


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