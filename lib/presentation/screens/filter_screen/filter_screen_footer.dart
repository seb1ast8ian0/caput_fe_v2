import 'dart:developer';

import 'package:Caput/domain/entities/neuron/Neuron.dart';
import 'package:Caput/domain/entities/neuron/payload/payloads/Task.dart';
import 'package:Caput/main.dart';
import 'package:Caput/presentation/states/neuron_state.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:Caput/presentation/widgets/util/buttons/caput_button_secondary.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FilterBottomInput extends StatefulWidget{

  final AnimationController animationController;
  const FilterBottomInput({super.key, required this.animationController});

  @override
  State<FilterBottomInput> createState() => _FilterBottomInputState();
}

class _FilterBottomInputState extends State<FilterBottomInput> {

  final neuronState = getIt.get<NeuronState>();
  final primaryTextInputController = TextEditingController();

  late Animation<double> _rotationAnimation;

  @override
  Widget build(BuildContext context) {

    _rotationAnimation = Tween<double>(
      begin: 0.0, 
      end: 0.5
    ).animate(
      CurvedAnimation(
        curve: const Cubic(.36,-0.5,.5,1.61), 
        parent: widget.animationController)
    );

    final inputTheme = Theme.of(context).inputDecorationTheme;

    final Widget buildNeuronInput = Align(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.backgroundColor as Color,
          border: Border(
            top: BorderSide(
              color: inputTheme.border!.borderSide.color,
              width: inputTheme.border!.borderSide.width,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children:[

                  RotationTransition(
                    turns: _rotationAnimation,
                    child: CaputButtonSecondary(
                      icon: Icons.keyboard_arrow_up, 
                      onPressed: (){
                          log('up');
                          var controller = widget.animationController;
                          
                          if(controller.isCompleted){
                            controller.reverse();
                          } else {
                            controller.forward();
                          }
                        }
                    ),
                  ),
                  
                  const SizedBox(width: 4),
        
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: inputTheme.fillColor,
                        border: Border.all(
                          color: inputTheme.border!.borderSide.color,
                          width: inputTheme.border!.borderSide.width,
                        ),
                      ),
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: primaryTextInputController,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 5,
                        style: Theme.of(context).textTheme.titleSmall,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12), //vertical: 12 on other devices
                          hintText: "Neues Neuron",
                          hintStyle: inputTheme.hintStyle,
                          border: InputBorder.none
                        ),
                      ),
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
                              neuronState.add(Neuron(const Uuid().v4(), const Uuid().v4(), Task("", false, DateTime.now().add(const Duration(seconds: 30)), "task", primaryTextInputController.text.trimRight(), 1), DateTime.now(), [], []));
                              primaryTextInputController.clear();
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
              const SizedBox(height: 4)
            ],
          ),
        ),
      ),
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