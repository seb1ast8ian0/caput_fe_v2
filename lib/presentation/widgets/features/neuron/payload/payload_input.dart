
import 'dart:async';
import 'dart:ui';

import 'package:Caput/presentation/util/colors/caput_colors.dart';
import 'package:flutter/material.dart';

class PayloadInput extends StatefulWidget {

  final AnimationController animationController;
  final ScrollController scrollController;

  /*

  widget.scrollController.animateTo(0, duration: Duration(milliseconds: 200), curve: Curves.bounceInOut);

  */

  const PayloadInput({Key? key, required this.animationController, required this.scrollController}) : super(key: key);

  @override
  PayloadInputState createState() => PayloadInputState();

}

class PayloadInputState extends State<PayloadInput>
  
  with TickerProviderStateMixin {

  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  //animationen für die icons
  late List<AnimationController> animationControllers = [];
  late List<Animation<Offset>> animationOffsets = [];

  @override
  void initState() {

    super.initState();

    _offsetAnimation =
      Tween<Offset>(
        begin: const Offset(0.0, 0.6), 
        end: Offset.zero
      ).animate(
          CurvedAnimation(
            parent: widget.animationController, 
            curve: Curves.easeInOutSine
          )
        );

    _opacityAnimation = CurvedAnimation(
      parent: widget.animationController, 
      curve: Curves.elasticInOut
    );

    for(int i = 0; i < 3 ; i++){ //Anzahl anpassen, wenn mehr items hinzukommen!
      animationControllers.add(
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 200),
        )
      );

      animationOffsets.add(
        Tween<Offset>(
          begin: const Offset(0.0, 1), 
          end: Offset.zero
        ).animate(
          CurvedAnimation(
            parent: animationControllers[i], 
            curve: const Cubic(.36,-0.79,.57,1.61)
          )
        )
      );
      

    }

  }

  @override
  Widget build(BuildContext context) {

    widget.animationController.addStatusListener((status) { 

      if(status == AnimationStatus.reverse){

        var counter = 0;

        Timer.periodic(const Duration(milliseconds: 0), (timer) {

          animationControllers[counter].reverse();

          counter++;
          
          if (counter == animationControllers.length) {
            timer.cancel();
          }

        });

        
      } else if(status == AnimationStatus.forward){

        var counter = 0;

        Timer.periodic(
          const Duration(milliseconds: 50), 
          (timer) {

            animationControllers[counter].forward();

            counter++;
            
            if (counter == animationControllers.length) {
              timer.cancel();
            }

          }
        );
      }
    });

    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _offsetAnimation,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              decoration: BoxDecoration(
                color: CaputColors.colorAppBarBackgroundLight.withOpacity(0.8),
                border: Border(
                  top: BorderSide(
                    color: CaputColors.colorLightGrey.withOpacity(0.6),
                    width: 0.4,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SlideTransition(
                      position: animationOffsets[0],
                      child: PayloadInputButton(
                        Icons.check, 
                        () {
                          print("tets");
                        }
                      )
                    ),
                    SlideTransition(
                      position: animationOffsets[1],
                      child: PayloadInputButton(
                        Icons.calendar_today_rounded, 
                        () => null
                      )
                    ),
                    SlideTransition(
                      position: animationOffsets[2],
                      child: PayloadInputButton(
                        Icons.link, 
                        () => null
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PayloadInputButton extends StatelessWidget{

  final IconData icon;
  final Function()? onPressed;

  const PayloadInputButton(this.icon, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
      
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),

          image: const DecorationImage(
            image: AssetImage("assets/images/static_noise.jpeg"),
            fit: BoxFit.cover,
            opacity: 0.1
          ),
          
          border: Border.all(
              color: CaputColors.colorLightGrey.withOpacity(0.6),
              width: 0.6,
          ),

        ),
        child: InkWell(
            splashColor: Colors.grey[600],
            highlightColor: Colors.grey[400],
            onTap: (){print("object");},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Icon(
              icon,
              size: 24.0,
              color: CaputColors.colorBlue,
            ),
          ),
        ),
      ),
    );
  }

}
