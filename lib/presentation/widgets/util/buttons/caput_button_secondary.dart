
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/material.dart';

class CaputButtonSecondary extends StatelessWidget{

  final IconData icon;
  final Function()? onPressed;

  const CaputButtonSecondary({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 32,
        height: 32,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: CaputColors.colorBlue,
            ),
            RawMaterialButton(
              onPressed: onPressed,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}