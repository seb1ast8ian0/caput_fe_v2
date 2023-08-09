
import 'dart:developer';

import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class NeuronCheckButton extends StatefulWidget{

  final int index;
  const NeuronCheckButton({required this.index, super.key});

  @override
  State<NeuronCheckButton> createState() => _NeuronCheckButtonState();
  
}

class _NeuronCheckButtonState extends State<NeuronCheckButton> {
  
  bool _checked = false;

  bool isPlaying = false;
  late ConfettiController confettiController;

  @override
  void initState(){
    confettiController = ConfettiController(duration: const Duration(milliseconds: 400));
    super.initState();
  }

  @override
  void dispose(){
    confettiController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget inner = Container();

    if(_checked){
      inner = ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Container(
          color: Colors.black12,
          width: 10,
          height: 10,
        )
      );
    }

    Widget innerContainer = Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: OverflowBox(
            maxWidth: 50, 
            maxHeight: 100, 
            child: Container(
              transform: Matrix4.diagonal3Values(0.18, 0.18, 0.18),
              child: ConfettiWidget(
                confettiController: confettiController, 
                shouldLoop: false,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0.4,
                numberOfParticles: 1,
                minBlastForce: 0.2,
                maxBlastForce: 0.4, 
                gravity: 0.1,
                particleDrag: 0.1,
              ),
            ),
          ),
        ),
      ],
    );
    
    return Container(
      padding: const EdgeInsets.only(right: 0),
      constraints: const BoxConstraints.tightForFinite(width: 30),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          inner,
          Center(
            child: innerContainer
          ),
          RawMaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
            constraints: BoxConstraints.tight(const Size.square(14)),
            onPressed: () {
              _checked ? log("already checked") : action();
            },
            enableFeedback: true,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              child: Container(
                width: 14,
                height: 14,
                color: CaputColors.colorLightGrey.withOpacity(0.8),
              ),
            ),
          ),
        ],
      )
    );
  }

  void action() {

    setState(() {
        _checked = true;
    });

    confettiController.play();

    Future.delayed(const Duration(milliseconds: 150), () {

      confettiController.stop();
      
    });

    Future.delayed(const Duration(milliseconds: 800), () {

      if(_checked){
        //TODO Check Task
      }

      setState(() {
        
        _checked = false;
      });
      
  });

  }
}