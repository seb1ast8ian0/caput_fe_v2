// Interface für die Buttons
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class CaputSelectableButton {
  bool isSelected = false;
  String get buttonKey;
  Widget buildButton(BuildContext context, VoidCallback onPressed);
}

typedef SelectionCallback = void Function(List<CaputSelectableButton> selectedItems);

class CaputSelectableButtonWidget extends StatefulWidget {

  final List<CaputSelectableButton> buttons;
  final SelectionCallback onSelectionChanged;
  final bool isSingleSelect; 
  final double? gap;
  final bool? expanded;

  CaputSelectableButtonWidget({
    this.expanded = false,
    this.gap,
    required this.buttons,
    required this.onSelectionChanged,
    this.isSingleSelect = false,
  });

  @override
  _CaputSelectableButtonWidgetState createState() => _CaputSelectableButtonWidgetState();
}

class _CaputSelectableButtonWidgetState extends State<CaputSelectableButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.buttons.asMap().entries.map((entry) {

        final CaputSelectableButton button = entry.value;
        final int index = entry.key;

        return Expanded(
          flex: widget.expanded! ? 1 : 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: widget.expanded! ? 1 : 0,
                child: button.buildButton(context, () {
                  setState(() {
                    if (widget.isSingleSelect) {
                      // Single Select
                      widget.buttons.forEach((btn) => btn.isSelected = false); // Alle Buttons zurücksetzen
                    }
                    button.isSelected = !button.isSelected;
                    widget.onSelectionChanged(getSelectedItems());
                  });
                }),
              ),

              if (index != widget.buttons.length - 1)
                SizedBox(width: widget.gap ?? 0)
                
            ],
          ),
        );
      }).toList(),
    );
  }

  List<CaputSelectableButton> getSelectedItems() {
    return widget.buttons.where((button) => button.isSelected).toList();
  }
}
