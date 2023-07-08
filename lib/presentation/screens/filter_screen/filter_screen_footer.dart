import 'dart:developer';
import 'dart:ui';

import 'package:Caput/domain/controllers/tag_controller.dart';
import 'package:Caput/domain/entities/neuron/Neuron.dart';
import 'package:Caput/domain/entities/neuron/payload/Payload.dart';
import 'package:Caput/domain/entities/neuron/tag/tag.dart';
import 'package:Caput/main.dart';
import 'package:Caput/presentation/states/neuron_state.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:Caput/presentation/widgets/features/textfield/caput_text_field.dart';
import 'package:Caput/presentation/widgets/util/buttons/caput_button_secondary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FilterBottomInput extends StatefulWidget{

  final AnimationController animationController;
  final Payload payload;

  const FilterBottomInput({super.key, required this.payload, required this.animationController});

  @override
  State<FilterBottomInput> createState() => _FilterBottomInputState();

}

class _FilterBottomInputState extends State<FilterBottomInput> {

  late Animation<double> _rotationAnimation;
  late Animation<Color?> _borderColorAnimation;
  late RichTextFieldController textController;

  @override
  void initState() {

    super.initState();
    textController = RichTextFieldController();

  }

  @override
  Widget build(BuildContext context) {
    
    final neuronState = getIt.get<NeuronState>();
    final inputTheme = Theme.of(context).inputDecorationTheme;

    _borderColorAnimation = ColorTween(
      begin: inputTheme.border!.borderSide.color,
      end: Colors.transparent,
    ).animate(widget.animationController);
    _rotationAnimation = Tween<double>(
      begin: 0.0, 
      end: 0.5
    ).animate(
      CurvedAnimation(
        curve: const Cubic(.36,-0.5,.5,1.61), 
        parent: widget.animationController)
    );

    void handleButtonUp(){
      log('up');
      var controller = widget.animationController;
      if(controller.isCompleted){
        controller.reverse();
      } else {
        controller.forward();
      }
    }
    final buttonUp = RotationTransition(
      turns: _rotationAnimation,
      child: CaputButtonSecondary(
        icon: Icons.keyboard_arrow_up, 
        onPressed: handleButtonUp
      ),
    );
    
    final textField = Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: inputTheme.fillColor,
          border: Border.all(
            color: inputTheme.border!.borderSide.color,
            width: inputTheme.border!.borderSide.width,
          ),
        ),
        child: CaputTextField(
          controller: textController,
        )
      ),
      
    );
    
    void handleButtonAdd(){

    }
    final buttonAdd = CaputButtonSecondary(
      icon: Icons.add, 
      onPressed: () => handleButtonAdd()
    );
    
    void handleButtonGo(){

      //log('go');
      
      Neuron neuron = Neuron(const Uuid().v4(), const Uuid().v4(), widget.payload.copy(), DateTime.now(), [], []);
      neuron.payload.caption = textController.text.trimRight();
      
      //log(neuron.payload.caption);
      neuronState.add(neuron);

      textController.clear();
      widget.animationController.reverse();

    }

    final buttonGo = ClipRRect(
      borderRadius: BorderRadius.circular(17),
      child: Container(
        color: CaputColors.colorBlue,
        width: 34,
        height: 34,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(
              Icons.keyboard_double_arrow_right,
              size: 24,
              color: Colors.white,
            ),
            RawMaterialButton(
              onPressed: handleButtonGo,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            )
          ],
        ),
      ),
    );

    final Widget buildNeuronInput = AnimatedBuilder(
      animation: _borderColorAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor as Color,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:[
                    buttonUp,
                    const SizedBox(width: 4),
                    textField,
                    const SizedBox(width: 4),
                    buttonAdd,
                    const SizedBox(width: 4),
                    buttonGo
                  ],
                ),
                
              ],
            ),
          ),
        );
      },
    );

    return Container(
      color: Theme.of(context).bottomAppBarTheme.color,
      child: SafeArea(
        right: false,
        left: false,
        top: false,
        bottom: true,
        child: buildNeuronInput
      ),
    );
  
  }

}
