import 'dart:developer';
import 'dart:ui';

import 'package:Caput/presentation/screens/settings_screen/settings_screen.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatefulWidget{

  const MainAppBar({super.key});

  @override
  State<MainAppBar> createState() => _MainAppBarState();
  
}

class _MainAppBarState extends State<MainAppBar> {

  @override
  Widget build(BuildContext context) {

    var appBarBackgroundColor = Theme.of(context).appBarTheme.backgroundColor as Color;
    

    return SliverAppBar(
      backgroundColor: Colors.transparent,
      centerTitle: false,
      pinned: true,
      expandedHeight: 100,
      elevation: 0,
      flexibleSpace: Stack(
        children: [
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                color: appBarBackgroundColor.withOpacity(0.6),
              ),
            ),
          ),
      
          FlexibleSpaceBar(
            expandedTitleScale: 1.2,
            title:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "CAPUT",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: CaputColors.colorBlue
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      log("settings");
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 18,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/logo_caput_transparent.png'),
                        radius: 18,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]
      ),
    );

  }

}
