import 'dart:developer';

import 'package:Caput/presentation/states/theme_state.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:Caput/presentation/widgets/features/textfield/caput_text_field.dart';
import 'package:Caput/presentation/widgets/util/buttons/caput_button_secondary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TestScreen extends StatefulWidget {

  

  const TestScreen({ Key? key }) : super(key: key);


  @override
  TestScreenState createState() => TestScreenState();
}

class TestScreenState extends State<TestScreen> {

  

  @override
  Widget build(BuildContext context) {

    final controller = RichTextFieldController();

    final Widget buildInput = Container(
    decoration: BoxDecoration(
    color: Theme.of(context).appBarTheme.backgroundColor as Color
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:[
                CaputButtonSecondary(
                  icon: Icons.keyboard_arrow_up, 
                  onPressed: (){
                      log('up');
                    }
                ),
                
                const SizedBox(width: 4),
                
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: CaputTextField(
                      controller: controller,
                    )
                  ),
                  
                ),
          
                const SizedBox(width: 4),
                
                CaputButtonSecondary(
                  icon: Icons.add, 
                  onPressed: () => {
                    log('add media')
                  }
                ),
          
                const SizedBox(width: 4),
          
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: CaputColors.colorBlue,
                    width: 32,
                    height: 32,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(
                          Icons.keyboard_double_arrow_right,
                          size: 24,
                          color: Colors.white,
                        ),
                        RawMaterialButton(
                          onPressed: () {
          
                            log('go');
        
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    ),
  );

    return Scaffold(
      body: SafeArea(

        child: Container(
          color: Theme.of(context).dialogBackgroundColor,
          //color: const Color.fromRGBO(12, 12, 12, 1),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CaputSecondaryButton(
                      highlightColor: CaputColors.colorBlue,
                      icon: Icons.check,
                      isHighlighted: true,
                      showLabelWhenNotHighlighted: false,
                      label: "Task",
                      onPressed: () {
                        log("hi");
                      },
                    ),
                    const SizedBox(width: 4),
                    CaputSecondaryButton(
                      highlightColor: CaputColors.colorBlue,
                      icon: Icons.calendar_month,
                      isHighlighted: false,
                      showLabelWhenNotHighlighted: false,
                      label: "Date",
                      onPressed: () {
                        log("hi");
                      },
                    )
                  ],
                ),
                const SizedBox(height: 8),
                const Spacer(flex: 1,),
                buildInput
                
              ],
            ),
          ),
        ),
      ),
    );
  }

                


}

class CaputSecondaryButton extends StatelessWidget {

IconData icon;
Function() onPressed;
bool isHighlighted;
Color highlightColor;
String? label;
bool? showLabelWhenNotHighlighted; //default: true

CaputSecondaryButton({ 
  required this.icon, 
  required this.onPressed, 
  required this.isHighlighted, 
  required this.highlightColor, 
  this.label, 
  this.showLabelWhenNotHighlighted,
  Key? key 
}) : super(key: key);
  

  @override
  Widget build(BuildContext context){

    final inputTheme = Theme.of(context).inputDecorationTheme;

    var themeColor = inputTheme.hintStyle!.color!;
    

    Color color = isHighlighted ? highlightColor : themeColor;
    Color backgroundColor = isHighlighted ? highlightColor.withOpacity(0.1) : inputTheme.fillColor!;

    double iconSize = label == null ? 28 : 20;

    

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        // border: Border.all(
        //   color: inputTheme.border!.borderSide.color,
        //   width: 1
        // )
      ),
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.blue,
        highlightColor: Colors.red,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon, 
                color: color,
                size: iconSize,
              ),
              _buildLabel(color)
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildLabel(Color color){

    bool showWhenInactive = showLabelWhenNotHighlighted == null ? true : showLabelWhenNotHighlighted!;

    bool showLabel = isHighlighted || !isHighlighted && showWhenInactive;

    if(label == null){
      return Container();
    }

    if(!showLabel){
      return Container();
    }

    return Row(
      children: [
        const SizedBox(width: 4),
        Text(
          label!,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w600
          ),
        ),
      ],
    );

    

  }
}