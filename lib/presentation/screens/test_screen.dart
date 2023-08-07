import 'dart:developer';

import 'package:Caput/presentation/screens/filter_input_screen/filter_input_screen.dart';
import 'package:Caput/presentation/states/theme_state.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:Caput/presentation/widgets/features/textfield/caput_text_field.dart';
import 'package:Caput/presentation/widgets/util/input/buttons/caput_button_secondary.dart';
import 'package:Caput/presentation/widgets/util/input/buttons/caput_secondary_button.dart';
import 'package:Caput/presentation/widgets/util/input/caput_select.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TestScreen extends StatefulWidget {

  const TestScreen({ Key? key }) : super(key: key);

  @override
  TestScreenState createState() => TestScreenState();

}

class TestScreenState extends State<TestScreen> {

  @override
  void initState() {
  
    super.initState();

  }

  

  @override
  Widget build(BuildContext context) {

    List<CaputSelectableButton> buttons = [
      CaputSecondaryButton(
        isSelected: true, 
        buttonKey: "1", 
        icon: Icons.add, 
        onPressed: (){}, 
        highlightColor: CaputColors.colorRed
      ),
      CaputSecondaryButton(
        isSelected: false, 
        buttonKey: "2", 
        icon: Icons.add, 
        onPressed: (){}, 
        highlightColor: CaputColors.colorOrange
      ),
      CaputSecondaryButton(
        isSelected: false, 
        buttonKey: "3", 
        icon: Icons.add, 
        onPressed: (){}, 
        highlightColor: CaputColors.colorGreen
      )
    ];

    void onSelectionChanged(List<CaputSelectableButton> selectedItems) {
      log(selectedItems.toString());
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).dialogBackgroundColor,
          //color: const Color.fromRGBO(12, 12, 12, 1),
          child: Center(
            child: SizedBox(
              height: 40,
              child: CaputSelectableButtonWidget(
                expanded: false,
                gap: 8,
                isSingleSelect: false,
                buttons: buttons,
                onSelectionChanged: onSelectionChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }

                


}
