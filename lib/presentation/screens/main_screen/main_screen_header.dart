import 'dart:ui';

import 'package:Caput/presentation/util/colors/caput_colors.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatefulWidget{

  const MainAppBar({super.key});

  @override
  State<MainAppBar> createState() => _MainAppBarState();
  
}

class _MainAppBarState extends State<MainAppBar> {

  @override
  Widget build(BuildContext context) {

    const appBarBackgroundColor = CaputColors.colorAppBarBackgroundLight;
    
    return SliverAppBar(

      backgroundColor: Colors.transparent,
      centerTitle: false,
      pinned: true,
      expandedHeight: 100,
      elevation: 0,
      
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: appBarBackgroundColor.withOpacity(0.6),
          border: Border(
            bottom: BorderSide(
              color: CaputColors.colorLightGrey.withOpacity(0.6),
              width: 0.4,
            ),
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: CaputColors.colorAppBarBackgroundLight.withOpacity(0.6),
                ),
              ),
            ),
      
            FlexibleSpaceBar(
              expandedTitleScale: 1.2,
              title:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "CAPUT",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: CaputColors.colorBlue
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: CaputColors.colorLightGrey.withOpacity(0.6),
                      radius: 19,
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/pb_dummy.jpeg'),
                        radius: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]
        ),
      ),
    );

  }

}
