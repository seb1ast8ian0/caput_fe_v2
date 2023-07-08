import 'package:flutter/material.dart';

class MainNavBar extends StatelessWidget{

  const MainNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Stack(
        children: [
          BottomAppBar(
            elevation: 0,
            color: (Theme.of(context).appBarTheme.backgroundColor as Color).withOpacity(0.6),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                   SizedBox(height: 30)
                ],
              ),
            ),
          ),
        ],
      );
  }

}