import 'dart:developer';
import 'dart:ui';

import 'package:Caput/domain/bloc/neuron_input/neuron_input_bloc.dart';
import 'package:Caput/domain/bloc/neurons/neurons_bloc.dart';
import 'package:Caput/domain/bloc/neurons/neurons_event.dart';
import 'package:Caput/domain/bloc/neurons/neurons_state.dart';
import 'package:Caput/domain/bloc/tags/tags_bloc.dart';
import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/entities/neuron/payloads/note.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/main.dart';
import 'package:Caput/presentation/screens/filter_screen/filter_screen_footer.dart';
import 'package:Caput/presentation/screens/filter_screen/filter_screen_header.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:Caput/presentation/widgets/features/neuron/neuron_list_builder.dart';
import 'package:Caput/presentation/widgets/features/neuron/payload/payload_input.dart';
import 'package:Caput/presentation/widgets/features/neuron/tag/tag_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class FilterScreen extends StatefulWidget {

  final Filter filter;

  const FilterScreen(this.filter, {super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();

}

class _FilterScreenState extends State<FilterScreen> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late ScrollController _scrollController;
  
  late NeuronsBloc neuronsBloc;
  late NeuronInputBloc neuronInputBloc;
  
  @override
  void initState() {

    neuronsBloc = context.read<NeuronsBloc>();
    neuronInputBloc = context.read<NeuronInputBloc>();
    
    TagsList tl = Get.find();
    List<Tag> tags = tl.getTags();

    log(tags.toString());

    neuronInputBloc.add(NeuronInputCleanEvent());

    Filter filter = getFilter(
      List.from({}), //tags.first, tags.last
      LogicalOperator.or,
      List.from({}), //NeuronType.date
      DateOption.all
    );
    
    neuronsBloc.add(GetNeuronsEvent(
      filter: filter
    ));

    _scrollController = ScrollController();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
  
    _opacityAnimation = CurvedAnimation(
      parent: _animationController, 
      curve: Curves.elasticInOut
    );
    
    super.initState();

  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: FilterAppBar(widget.filter.caption, _animationController),
      body: Stack(
        children: [
          Opacity(
            opacity: 0,
            child: SizedBox(
              height: 5,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: CaputColors.colorRed,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: CaputColors.colorBlue,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: CaputColors.colorGreen,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: CaputColors.colorOrange,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.loose,
                  alignment: Alignment.bottomLeft,
                  children: [
                    BlocBuilder<NeuronsBloc, NeuronState>(
                      builder: (context, state) {
                        switch (state.status) {
                          case NeuronStateStatus.success:
                            return buildNeuronBuilder(context, state);
                          case NeuronStateStatus.loading:
                            return const Text("Loading...");
                          default:
                            return const Text("Error");
                        }
                      },
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.black26,
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
                        //PayloadInput
                        PayloadInput(
                          animationController: _animationController,
                          scrollController: _scrollController,
                        ),
                        //TagSearchBar
                        TagSearchBar(
                          animationController: _animationController
                        )
                      ],
                    ),
                    
                  ]
                ),
              ),
              FilterBottomInput(
                animationController: _animationController
              )
            ]
          ),
        ],
      )
    );
  
  }

  static Filter getFilter(
    List<Tag> tags, 
    LogicalOperator tagsOperator, 
    List<NeuronType> neuronTypes,
    DateOption dateOption
  ){

    DateTime now = DateTime.now();

    return Filter(
      filterId: const Uuid().v4(), 
      userId: const Uuid().v4(), 
      caption: "Test Filter", 
      creationTs: now, 
      updateTs: now, 
      tags: tags, 
      tagsOperator: tagsOperator, 
      neuronTypes: neuronTypes,
      dateOption: dateOption
    );

  }
  
  buildNeuronBuilder(BuildContext context, NeuronState state) {
      
    return NeuronBuilder(neurons: state.neurons, scrollController: _scrollController);

  }

  
}


