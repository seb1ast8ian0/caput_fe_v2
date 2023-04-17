import 'package:flutter/material.dart';

class MainNavBar extends StatelessWidget{

  const MainNavBar({super.key});

  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context).inputDecorationTheme;
    
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
                  color: theme.border!.borderSide.color,
                  width: theme.border!.borderSide.width,
                ),
              ),
            ),
            
            child: BottomAppBar(
              elevation: 0,
              color: (Theme.of(context).appBarTheme.backgroundColor as Color).withOpacity(0.6),
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