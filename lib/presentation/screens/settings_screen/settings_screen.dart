import 'package:Caput/main.dart';
import 'package:Caput/presentation/screens/settings_screen/settings_screen_header.dart';
import 'package:Caput/presentation/states/neuron_state.dart';
import 'package:Caput/presentation/states/theme_state.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget{
  const SettingsScreen({super.key});

  

  @override
  Widget build(BuildContext context) {

    var neuronState = getIt.get<NeuronState>();

    var highlightColor = MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.dark ? Colors.black12 : CaputColors.colorBlue.withOpacity(0.2));
    var themeMode = context.watch<ThemeState>().themeMode;
    var brigthButtonStyle = const ButtonStyle();
    var darkButtonStyle = const ButtonStyle();
    var systemButtonStyle = const ButtonStyle();

    if(themeMode == ThemeMode.light){

      brigthButtonStyle = ButtonStyle(backgroundColor: highlightColor);

    } else if(themeMode == ThemeMode.dark) {

      darkButtonStyle = ButtonStyle(backgroundColor: highlightColor);

    } else if(themeMode == ThemeMode.system){

      systemButtonStyle = ButtonStyle(backgroundColor: highlightColor);

    }

    Widget userTile = SettingsTile(
      isCustom: true,
      padding: const EdgeInsets.all(0),
      child: Ink(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/static_noise.jpeg"),
            fit: BoxFit.cover,
            opacity: 0.2
          ),
          
          gradient: const LinearGradient(
            colors: [Color.fromARGB(183, 77, 98, 232), CaputColors.colorBlue],
            stops: [0, 2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8)
        ),
        child:  Padding(
          padding:  const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hallo, Sebastian!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "dabei seit: 25.03.2023".toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),
              ),
            ],
          ),
        ),
      )
    );
    
    Widget languageTile = SettingsTile(
      isCustom: false,
      color: Theme.of(context).inputDecorationTheme.fillColor,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Sprache".toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: CaputColors.colorBlue
            ),
          ),
          Switch(
            value: false,
            onChanged: (value) {
              value = true;
          },
          )
        ],
      ),
    );

    Widget brightnessTile = SettingsTile(
      isCustom: false,
      color: Theme.of(context).inputDecorationTheme.fillColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Helligkeit".toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: CaputColors.colorBlue
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: TextButton.icon(
                  style: brigthButtonStyle,
                  onPressed: () {context.read<ThemeState>().setTheme(ThemeMode.light);}, 
                  icon: const Icon(Icons.sunny),
                  label: const Text("Hell"),
                ),
              ),

              TextButton.icon(
                onPressed: () {context.read<ThemeState>().setTheme(ThemeMode.dark);}, 
                icon: const Icon(Icons.dark_mode), 
                label: const Text("Dunkel"),
                style: darkButtonStyle,
              ),

              TextButton.icon(
                onPressed: () {context.read<ThemeState>().setTheme(ThemeMode.system);}, 
                icon: const Icon(Icons.phone_android), 
                label: const Text("Standard"),
                style: systemButtonStyle
              ),
            ],
          ),
          
        ],
      ),
    );
    
    Widget resetTile = SettingsTile(
      isCustom: false,
      color: Theme.of(context).inputDecorationTheme.fillColor,
      padding: const EdgeInsets.all(0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(
            icon: const Icon(Icons.delete),
            label: const Text("Zurücksetzen"),
            onPressed: () {
              neuronState.cleanUp();
            },
            style: ButtonStyle(
              iconColor: MaterialStateProperty.resolveWith((states) {return states.contains(MaterialState.pressed) ?  CaputColors.colorRed.withOpacity(0.6) : CaputColors.colorRed;}),
              foregroundColor: MaterialStateProperty.resolveWith((states) {return states.contains(MaterialState.pressed) ?  CaputColors.colorRed.withOpacity(0.6) : CaputColors.colorRed;})
            )
          ),
        ],
      ),
    );
    
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: const SettingsAppBar(),
      body: SingleChildScrollView(
        //physics: AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            userTile,

            const SizedBox(height: 8),

            languageTile,

            const SizedBox(height: 8),

            brightnessTile,

            const SizedBox(height: 8),

            resetTile
            
          ],
        ),
      )
    );
  }
}

class SettingsTile extends StatelessWidget {

final Widget? child;
final Color? color;
final EdgeInsetsGeometry padding;
final bool isCustom;

const SettingsTile({ this.child, this.color, required this.padding, required this.isCustom, key }) : super(key: key);

  @override
  Widget build(BuildContext context){

    var theme = Theme.of(context).inputDecorationTheme;
    var decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Theme.of(context).dialogBackgroundColor,
      border: Border.all(
        color: theme.border!.borderSide.color,
        width: theme.border!.borderSide.width,
      )
    );

    if(isCustom){
      decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      );
    }

    return Container(
      decoration: decoration,
      child: Padding(
        padding: padding,
        child: child
      ),
    );
  }
}