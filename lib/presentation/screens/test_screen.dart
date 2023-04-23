import 'package:Caput/presentation/states/neuron_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TestScreen extends StatefulWidget {

  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<TestScreen> with SingleTickerProviderStateMixin {

  late NeuronState neuronState;
  late AnimationController _animationController;
  late ScrollController _scrollController;

  int _num = 1;


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Column(
        children: [
          SizedBox(height: 100,),
          RawMaterialButton(
            child: Text("hi"),
            onPressed: (){setState(() {
            if(_num == 0){
              _num = 1;
            } else {
              _num = 0;
            }
          });}),
          AnimatedCrossFade(
            duration:  const Duration(milliseconds: 200),
            firstChild: Container(
              height: 150,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: DateTime.now(),
                use24hFormat: true,
                onDateTimeChanged: (time){}
              ),
            ),
            secondChild: Container(
              height: 150,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                use24hFormat: true,
                onDateTimeChanged: (time){}
              ),
            ),
    
            crossFadeState: _num == 1 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          ),
        ],
      ),
    );
  
  }
}
