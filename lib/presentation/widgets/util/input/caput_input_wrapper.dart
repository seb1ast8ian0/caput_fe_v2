import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CaputInputWrapper extends StatelessWidget {

  final String label;
  final Widget child;
  final bool isEnabled;

  const CaputInputWrapper({
    super.key,
    required this.isEnabled,
    required this.label,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEnabled,
      child: AnimatedOpacity(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 200),
        opacity: isEnabled ? 1: 0.5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).dialogBackgroundColor
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: CaputColors.colorBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w800
                  ),
                ),
                child
              ]
            ),
          ),
        ),
      ),
    );
  }

}
