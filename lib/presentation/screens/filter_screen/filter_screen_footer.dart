
import 'package:Caput/domain/entities/neuron.dart';
import 'package:Caput/domain/entities/payloads/Task.dart';
import 'package:Caput/main.dart';
import 'package:Caput/presentation/states/neuron_state.dart';
import 'package:Caput/presentation/util/colors/caput_colors.dart';
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

    final Widget buildNeuronInput = Align(
      child: Container(
        decoration: BoxDecoration(
          color: CaputColors.colorAppBarBackgroundLight,
          border: Border(
            top: BorderSide(
              color: CaputColors.colorLightGrey.withOpacity(0.6),
              width: 0.4,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                          print('up');
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
                        borderRadius: BorderRadius.circular(12),
                        color: CaputColors.colorBackgroundLight,
                        border: Border.all(
                          color: CaputColors.colorLightGrey.withOpacity(0.6),
                          width: 0.6,
                        ),
                      ),
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: primaryTextInputController,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 5,
                        style: const TextStyle(
                          fontSize: 14
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12), //vertical: 12 on other devices
                          hintText: "Neues Neuron",
                          hintStyle: TextStyle(
                            color: CaputColors.colorTextSecondaryLight,
                            fontSize: 14
                          ),
                          border: InputBorder.none
                        ),
                      ),
                    ),
                    
                  ),

                  const SizedBox(width: 4),
                  
                  CaputButtonSecondary(
                    icon: Icons.add, 
                    onPressed: () => {
                      print('add')
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
                              print('go');
                              neuronState.add(Neuron(const Uuid().v4(), const Uuid().v4(), Task("", false, DateTime.now().add(const Duration(seconds: 30)), "task", primaryTextInputController.text, 1), DateTime.now()),);
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
      color: CaputColors.colorAppBarBackgroundLight,
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