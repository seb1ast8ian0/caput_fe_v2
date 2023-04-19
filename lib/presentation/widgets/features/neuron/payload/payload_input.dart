import 'dart:developer';
import 'dart:ui';

import 'package:Caput/domain/entities/neuron/payload/Payload.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/material.dart';

class PayloadInput extends StatefulWidget {

  final AnimationController animationController;
  final ScrollController scrollController;

  final Function(Payload) onPayloadChanged;

  /*

  widget.scrollController.animateTo(0, duration: Duration(milliseconds: 200), curve: Curves.bounceInOut);

  */

  const PayloadInput({Key? key, required this.onPayloadChanged, required this.animationController, required this.scrollController}) : super(key: key);

  @override
  PayloadInputState createState() => PayloadInputState();

}

class PayloadInputState extends State<PayloadInput> with TickerProviderStateMixin {

  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;


  double _height = 0;


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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _offsetAnimation,
        child: IgnorePointer(
          ignoring: false,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor!.withOpacity(0.6),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PayloadInputButton(
                            Icons.check, 
                            () {
                              setState(() {
                                if(_height == 0){
                                  _height = 200;
                                } else {
                                  _height = 0;
                                }
                                
                              });
                              
                            }
                          ),
                          const SizedBox(width: 8),
                          PayloadInputButton(
                            Icons.calendar_today_rounded, 
                            () => null
                          ),
                          const SizedBox(width: 8),
                          PayloadInputButton(
                            Icons.link, 
                            () => null
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      curve: Curves.easeInOutSine,
                      constraints: BoxConstraints(maxHeight: _height),
                      child: LimitedBox(
                        maxHeight: _height,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                const Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Text(
                                    "Deadline:",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: CaputColors.colorBlue
                                    ),
                                  ),
                                ),
                                
                                Row(
                                  children: [
                                    PayloadDateInput("Datum", Icons.calendar_month, () => null),
                                    const SizedBox(width: 8,),
                                    
                                    PayloadTimeInput("Uhrzeit", Icons.timer, () => null)
                                  ],
                                ),
                                const Divider(),
                                const Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Text(
                                    "Body: ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: CaputColors.colorBlue
                                    ),
                                  ),
                                ),
                                const Divider(),
                                const Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Text(
                                    "Tags: ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: CaputColors.colorBlue
                                    ),
                                  ),
                                ),
                                const Divider(),
                                const Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Text(
                                    "Priorität: ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: CaputColors.colorBlue
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4)

                                /**/
                              ]
                            ),
                          ),
                        ),
                      ),
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

    var borderTheme = Theme.of(context).inputDecorationTheme;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),

          image: const DecorationImage(
            image: AssetImage("assets/images/static_noise.jpeg"),
            fit: BoxFit.cover,
            opacity: 0.1
          ),
          
          border: Border.all(
              color: borderTheme.border!.borderSide.color,
              width: borderTheme.border!.borderSide.width,
          ),

        ),
        child: InkWell(
            splashColor: Colors.grey[600],
            highlightColor: Colors.grey[400],
            onTap: onPressed,
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

class PayloadTimeInput extends StatelessWidget{

  final IconData icon;
  final Function()? onPressed;
  final String label;

  const PayloadTimeInput(this.label, this.icon, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {

    var borderTheme = Theme.of(context).inputDecorationTheme;

    var pickerThemeDark = ThemeData().copyWith(
      colorScheme: const ColorScheme.dark(
        primary: CaputColors.colorBlue,
        onPrimary: CaputColors.colorAppBarBackgroundLight,
        surface: CaputColors.colorTextPrimaryLight,
        onSurface: CaputColors.colorAppBarBackgroundLight
      ),
    );

    var pickerThemeLight = ThemeData().copyWith(
      colorScheme: const ColorScheme.light(
        primary: CaputColors.colorBlue,
        //onPrimary: CaputColors.colorAppBarBackgroundLight,
        //surface: CaputColors.colorAppBarBackgroundLight,
        onSurface: CaputColors.colorTextPrimaryLight
      ),
    );

    var pickerTheme = Theme.of(context).brightness == Brightness.light ? pickerThemeLight : pickerThemeDark;

    
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
        
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
        
            image: const DecorationImage(
              image: AssetImage("assets/images/static_noise.jpeg"),
              fit: BoxFit.cover,
              opacity: 0.1
            ),
            
            border: Border.all(
                color: borderTheme.border!.borderSide.color,
                width: borderTheme.border!.borderSide.width,
            ),
        
          ),
          child: InkWell(
              splashColor: Colors.grey[600],
              highlightColor: Colors.grey[400],
              onTap: () {
                onPressed;
                showTimePicker(
                  context: context,
                  helpText: "",
                  cancelText: "Zurück",
                  confirmText: "Okay",
                  initialTime: TimeOfDay(hour: DateTime.now().hour, minute: 60),
                  builder: (context, child) {
                    return Theme(
                      data: pickerTheme,
                      child: child!
                    );
                  },
                );
              },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 24.0,
                    color: CaputColors.colorBlue,
                  ),
                  const SizedBox(width: 8,),
                  Text(label, style: const TextStyle(color: CaputColors.colorBlue),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

class PayloadDateInput extends StatelessWidget{

  final IconData icon;
  final Function()? onPressed;
  final String label;

  const PayloadDateInput(this.label, this.icon, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {

    var borderTheme = Theme.of(context).inputDecorationTheme;

    var pickerThemeDark = ThemeData().copyWith(
      colorScheme: const ColorScheme.dark(
        primary: CaputColors.colorBlue,
        onPrimary: CaputColors.colorBackgroundDark,
        surface: CaputColors.colorBackgroundDark,
        onSurface: CaputColors.colorBlue,
        background: Colors.grey,
        
      ),
    );

    var pickerThemeLight = ThemeData().copyWith(
      colorScheme: const ColorScheme.light(
        primary: CaputColors.colorBlue,
        //onPrimary: CaputColors.colorAppBarBackgroundLight,
        //surface: CaputColors.colorAppBarBackgroundLight,
        onSurface: CaputColors.colorTextPrimaryLight
      ),
    );

    var pickerTheme = Theme.of(context).brightness == Brightness.light ? pickerThemeLight : pickerThemeDark;

    
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
        
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
    
            image: const DecorationImage(
              image: AssetImage("assets/images/static_noise.jpeg"),
              fit: BoxFit.cover,
              opacity: 0.1
            ),
            
            border: Border.all(
                color: borderTheme.border!.borderSide.color,
                width: borderTheme.border!.borderSide.width,
            ),
    
          ),
          child: InkWell(
              splashColor: Colors.grey[600],
              highlightColor: Colors.grey[400],
              onTap: () {
                onPressed;
                showDatePicker(
                  context: context,
                  helpText: "",
                  cancelText: "Zurück",
                  confirmText: "Okay",
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 3650)),
                  initialDate: DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: pickerTheme,
                      child: child!
                    );
                  },
                );
              },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 24.0,
                    color: CaputColors.colorBlue,
                  ),
                  const SizedBox(width: 8,),
                  Text(label, style: const TextStyle(color: CaputColors.colorBlue),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

