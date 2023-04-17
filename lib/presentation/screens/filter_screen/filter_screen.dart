import 'package:Caput/main.dart';
import 'package:Caput/presentation/screens/filter_screen/filter_screen_footer.dart';
import 'package:Caput/presentation/screens/filter_screen/filter_screen_header.dart';
import 'package:Caput/presentation/states/neuron_state.dart';
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
  late ScrollController _scrollController;

  @override
  void initState() {

    super.initState();
    _fetchData();

     _scrollController = ScrollController();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
  
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {

    setState(() {
      _isLoading = false;
      neuronState = getIt.get<NeuronState>();
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: FilterAppBar(widget.title),
      body: _isLoading
      ? const CircularProgressIndicator()
      : Column(children: [
          Expanded(
            child: Stack(
              fit: StackFit.loose,
              alignment: Alignment.bottomLeft,
              children: [ 
                StreamBuilder(
                  stream: neuronState.stream$,
                  initialData: neuronState.current,
                  builder:(context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error'));
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(child: Text('No Data'));
                    } else {
                      return NeuronBuilder(neurons: snapshot.data, scrollController: _scrollController);
                    }
                  },
                ),
                PayloadInput(
                  animationController: _animationController,
                  scrollController: _scrollController,
                ),
              ]
            ),
          ),
          FilterBottomInput(animationController: _animationController)
        ]
      )
    );
  
  }
}
