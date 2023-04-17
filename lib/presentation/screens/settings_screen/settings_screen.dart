import 'package:Caput/presentation/screens/settings_screen/settings_screen_header.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget{
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: SettingsAppBar(),
      body: SingleChildScrollView(
        //physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SettingsTile(
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
            ),
            const SizedBox(height: 8),
            SettingsTile(
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
            ),
            const SizedBox(height: 8),
            SettingsTile(
              color: Theme.of(context).inputDecorationTheme.fillColor,
              padding: const EdgeInsets.all(16),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [



                      Material(
                        borderRadius: BorderRadius.circular(8),
                        child: TextButton.icon(
                          onPressed: () {}, 
                          icon: Icon(Icons.sunny), 
                          label: Text("Hell", style: Theme.of(context).textTheme.labelLarge,), 
                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(CaputColors.colorBlue.withOpacity(0.2))),
                        ),
                      ),


                      TextButton.icon(onPressed: () {}, icon: Icon(Icons.dark_mode), label: Text("Dunkel", style: Theme.of(context).textTheme.labelLarge,)),
                      TextButton.icon(onPressed: () {}, icon: Icon(Icons.phone_android), label: Text("Standard", style: Theme.of(context).textTheme.labelLarge,)),
                    ],
                  ),
                  
                ],
              ),
            ),
            const SizedBox(height: 8),
            SettingsTile(
              color: Theme.of(context).inputDecorationTheme.fillColor,
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Zurücksetzen",
                    style:  TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: CaputColors.colorRed
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}

class SettingsTile extends StatelessWidget {

Widget? child;
Color? color;
EdgeInsetsGeometry padding;

SettingsTile({ this.child, this.color, required this.padding, key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(8),
      color: color,
      child: Padding(
        padding: padding,
        child: child
      ),
    );
  }
}