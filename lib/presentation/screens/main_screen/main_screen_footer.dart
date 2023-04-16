import 'package:Caput/presentation/util/colors/caput_colors.dart';
import 'package:flutter/material.dart';

class MainNavBar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
        children: [
          Container(

            decoration: BoxDecoration(

              image: const DecorationImage(
                image: AssetImage("assets/images/static_noise.jpeg"),
                fit: BoxFit.cover,
                opacity: 0.1
              ),
              
              border: Border(
                top: BorderSide(
                  color: CaputColors.colorLightGrey.withOpacity(0.6),
                  width: 0.4,
                ),
              ),
            ),
            
            child: BottomAppBar(
              elevation: 0,
              color: CaputColors.colorAppBarBackgroundLight.withOpacity(0.6),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                     SizedBox(height: 30,),
                   
                  ],
                ),
              ),
            ),
          ),
        ],
      );
  }

}