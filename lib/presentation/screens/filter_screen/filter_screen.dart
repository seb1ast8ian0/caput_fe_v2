import 'dart:ui';

import 'package:Caput/domain/entities/neuron/payload/Payload.dart';
import 'package:Caput/domain/entities/neuron/payload/payloads/Note.dart';
import 'package:Caput/main.dart';
import 'package:Caput/presentation/screens/filter_screen/filter_screen_footer.dart';
import 'package:Caput/presentation/screens/filter_screen/filter_screen_header.dart';
import 'package:Caput/presentation/states/neuron_state.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:Caput/presentation/widgets/features/neuron/neuron_list_builder.dart';
import 'package:Caput/presentation/widgets/features/neuron/payload/payload_input.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {

  final String title;

  const FilterScreen(this.title, {super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> with SingleTickerProviderStateMixin {

  late NeuronState neuronState;
  bool _isLoading = true;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late ScrollController _scrollController;
  Payload payload = Note("", "note", "", 1);

  @override
  void initState() {

    super.initState();
    _fetchData();

     _scrollController = ScrollController();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
  
    _opacityAnimation = CurvedAnimation(
      parent: _animationController, 
      curve: Curves.elasticInOut
    );

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {

    setState(() {
      neuronState = getIt.get<NeuronState>();
      _isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: FilterAppBar(widget.title, _animationController),
      body: _isLoading
      ? const CircularProgressIndicator()
      : Column(children: [
          Expanded(
            child: Stack(
              fit: StackFit.loose,
              alignment: Alignment.bottomLeft,
              children: [ 
                StreamBuilder(
                  stream: neuronState.stream,
                  initialData: neuronState.current,
                  builder:(context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error', style: TextStyle(color: CaputColors.colorRed),));
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(child: Text('No Data', style: TextStyle(color: CaputColors.colorBlue),));
                    } else {
                      return NeuronBuilder(neurons: snapshot.data, scrollController: _scrollController);
                    }
                  },
                ),
                IgnorePointer(
                  ignoring: true,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PayloadInput(
                      onPayloadChanged: (pld) {
                        setState(() {
                          payload = pld;
                        });
                      },
                      animationController: _animationController,
                      scrollController: _scrollController,
                    ),
                  ],
                ),
                
              ]
            ),
          ),
          FilterBottomInput(payload, _animationController)
        ]
      )
    );
  
  }
}
