import 'dart:developer';
import 'dart:ui';

import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/material.dart';

class FilterAppBar extends StatefulWidget implements PreferredSizeWidget{
  
  final String title;
  final AnimationController animationController;
  
  const FilterAppBar(this.title, this.animationController, {super.key});

  @override
  State<FilterAppBar> createState() => _FilterAppBarState();
  
  @override
    Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FilterAppBarState extends State<FilterAppBar> {
  
  _FilterAppBarState();

  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    
    super.initState();

  }

  void onButtonBack(){

    log("navigate back");
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {

    var color = Theme.of(context).appBarTheme.backgroundColor;

    _colorAnimation = ColorTween(
      begin: color!.withOpacity(0.4),
      end: color,
    ).animate(widget.animationController);
    
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {

        return ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              decoration: BoxDecoration(
                color: _colorAnimation.value,
              ),
              child: SafeArea(
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
                            IconButton(
                              constraints: BoxConstraints.tight(const Size.square(38)),
                              iconSize: 24,
                              icon: const Icon(Icons.arrow_back_ios_new),
                              color: CaputColors.colorBlue, 
                              onPressed: () => onButtonBack(),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: CaputColors.colorBlue
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              ),
            ),
          ),
        );
        
      },
      
    );
  
  }

}

