import 'dart:developer';
import 'dart:ui';

import 'package:Caput/domain/entities/neuron/Neuron.dart';
import 'package:Caput/domain/entities/neuron/payload/Payload.dart';
import 'package:Caput/main.dart';
import 'package:Caput/presentation/states/neuron_state.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:Caput/presentation/widgets/util/buttons/caput_button_secondary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FilterBottomInput extends StatefulWidget{

  final AnimationController animationController;
  final Payload payload;

  const FilterBottomInput(this.payload, this.animationController, {super.key});

  @override
  State<FilterBottomInput> createState() => _FilterBottomInputState();
}

class _FilterBottomInputState extends State<FilterBottomInput> {

  final neuronState = getIt.get<NeuronState>();
  final primaryTextInputController = RichTextFieldController();

  late Animation<double> _rotationAnimation;
  late Animation<Color?> _borderColorAnimation;


  @override
  void initState() {

    primaryTextInputController.addListener(() {
      print(primaryTextInputController.value.text);
    });

    super.initState();

  }

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

    _borderColorAnimation = ColorTween(
      begin: inputTheme.border!.borderSide.color,
      end: Colors.transparent,
    ).animate(widget.animationController);

    

    final Widget buildNeuronInput = AnimatedBuilder(
      animation: _borderColorAnimation,
      builder: (context, child) {
        return Align(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor as Color,
              border: Border(
                top: BorderSide(
                  color: _borderColorAnimation.value!,
                  width: inputTheme.border!.borderSide.width,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                            enableInteractiveSelection: true,
                            textCapitalization: TextCapitalization.sentences,
                            controller: primaryTextInputController,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 5,
                            style: Theme.of(context).textTheme.titleSmall,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12), //vertical: 12 on other devices
                              hintText: "Neues Neuron...",
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
      
                                  Neuron neuron = Neuron(const Uuid().v4(), const Uuid().v4(), widget.payload.copy(), DateTime.now(), [], []);
                                  neuron.payload.caption = primaryTextInputController.text.trimRight();
                                  
                                  log(neuron.payload.caption);
                                  neuronState.add(neuron);
      
                                  primaryTextInputController.clear();
                                  widget.animationController.reverse();
      
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


class RichTextFieldController extends TextEditingController {


  
  RichTextFieldController() {
    
  }
  

  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
      composing: TextRange.empty,
    );
  }

  @override
  TextSpan buildTextSpan({
    required context,
    TextStyle? style,
    required bool withComposing,
  }) {
    List<InlineSpan> children = [];

    List<String> textInput = super.text.split(" ");
    log(textInput.toString());

    children = [];

    

    for(String text in textInput){

      RegExp regExp = RegExp(
        r"https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)"
      );

      // Überprüfen Sie, ob der Text eine URL enthält
      bool isUrl = regExp.hasMatch(text);

      if(text.startsWith("#")){
        children.add(TextSpan(text: "$text ", style: const TextStyle(color: CaputColors.colorBlue)));
      } else if(isUrl) {
        children.add(TextSpan(text: "$text ", style: const TextStyle(color: CaputColors.colorRed)));
      }else {
        children.add(TextSpan(text: "$text "));
      }
    }
    
    return TextSpan(style: style, children: children);
  }
}

