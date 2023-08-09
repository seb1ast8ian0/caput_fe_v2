import 'package:Caput/domain/bloc/input_blocs/filter_input/filter_input_bloc.dart';
import 'package:Caput/domain/bloc/input_blocs/neuron_input/neuron_input_bloc.dart';
import 'package:Caput/domain/bloc/data_blocs/neurons/neurons_bloc.dart';
import 'package:Caput/domain/bloc/data_blocs/tags/tags_bloc.dart';
import 'package:Caput/domain/bloc/search_blocs/tags_search/tags_search_bloc.dart';
import 'package:Caput/presentation/screens/main_screen/main_screen.dart';
import 'package:Caput/presentation/states/theme_state.dart';
import 'package:Caput/presentation/util/consts/caput_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Caput extends StatefulWidget{

  const Caput({super.key});

  @override
  State<Caput> createState() => _CaputState();
}

class _CaputState extends State<Caput> {

  late NeuronsBloc neuronsBloc;
  late TagsBloc tagsBloc;
  late TagsSearchBloc tagsSearchBloc;
  late NeuronInputBloc neuronInputBloc;
  late FilterInputBloc filterInputBloc;

  @override
  void initState() {

    neuronsBloc = NeuronsBloc();

    tagsBloc = TagsBloc();
    tagsBloc.add(InitTagsEvent());

    tagsSearchBloc = TagsSearchBloc();
    neuronInputBloc = NeuronInputBloc(
      neuronsBloc: neuronsBloc
    );

    filterInputBloc = FilterInputBloc();
    
    super.initState();

  }

  @override
  void dispose() {
    
    neuronsBloc.close();
    tagsBloc.close();
    neuronsBloc.close();
    neuronInputBloc.close();
    filterInputBloc.close();

    super.dispose();
  }


  @override
  Widget build(BuildContext context){


    return MultiBlocProvider(
      providers: [
        BlocProvider<NeuronsBloc>.value(value: neuronsBloc),
        BlocProvider<TagsBloc>.value(value: tagsBloc),
        BlocProvider<TagsSearchBloc>.value(value: tagsSearchBloc),
        BlocProvider<NeuronInputBloc>.value(value: neuronInputBloc),
        BlocProvider<FilterInputBloc>.value(value: filterInputBloc)
      ],
      child: MaterialApp(
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
      )

    );
    
    
    

  }
}