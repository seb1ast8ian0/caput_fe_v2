
import 'package:Caput/presentation/widgets/util/input/caput_select.dart';
import 'package:flutter/material.dart';

class CaputSecondaryButton<E> extends StatelessWidget implements CaputSelectableButton<E> {

  @override
  bool isSelected;

  @override
  E buttonKey;

  IconData? icon;
  Function() onPressed;
  Color highlightColor;
  String? label;
  bool? showLabelWhenNotHighlighted; //default: true

  CaputSecondaryButton({ 
    required this.isSelected,
    required this.buttonKey,
    this.icon, 
    required this.onPressed,
    required this.highlightColor, 
    this.label, 
    this.showLabelWhenNotHighlighted,
    Key? key 
  }) : super(key: key);

  
  @override
  String toStringShort() {
    return 'CaputSecondaryButton{isSelected: $isSelected, buttonKey: $buttonKey, label: $label}';
  }

  @override
  Widget buildButton(BuildContext context, VoidCallback onPressed) {
    
    final inputTheme = Theme.of(context).inputDecorationTheme;
    var themeColor = inputTheme.hintStyle!.color!;

    Color color = isSelected ? highlightColor : themeColor;
    Color backgroundColor = isSelected ? highlightColor.withOpacity(0.1) : inputTheme.fillColor!;

    double iconSize = label == null ? 28 : 20;

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: (){
          onPressed();
          //this.onPressed();
        },
        borderRadius: BorderRadius.circular(8),
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null)
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
  

  @override
  Widget build(BuildContext context){

    return buildButton(context, onPressed);

  }

  Widget _buildLabel(Color color){

    bool showWhenInactive = showLabelWhenNotHighlighted == null ? true : showLabelWhenNotHighlighted!;

    bool showLabel = isSelected || !isSelected && showWhenInactive;

    if(label == null){
      return Container();
    }

    if(!showLabel){
      return Container();
    }

    return Row(
      children: [
        if(icon != null)
          const SizedBox(width: 8),
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