import 'package:flutter/material.dart';

class CaputPrimaryButton extends StatelessWidget {

  String label;
  Color color;
  Function() onPressed;

  CaputPrimaryButton({
    required this.label,
    required this.color,
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: (){
        onPressed();
      },
      elevation: 0,
      highlightElevation: 0,
      constraints: const BoxConstraints(maxHeight: 40),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      fillColor: color,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16
          ),
        ),
      ),
    );
  }
}