import 'dart:math';

import 'package:Caput/domain/bloc/input_blocs/neuron_input/neuron_input_bloc.dart';
import 'package:Caput/domain/bloc/data_blocs/neurons/neurons_bloc.dart';
import 'package:Caput/domain/entities/neuron/Neuron.dart';
import 'package:Caput/domain/entities/neuron/payload.dart';
import 'package:Caput/domain/entities/neuron/payloads/date.dart';
import 'package:Caput/domain/entities/neuron/payloads/note.dart';
import 'package:Caput/domain/entities/neuron/payloads/task.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:Caput/presentation/widgets/util/input/textfield/caput_text_editing_controller.dart';
import 'package:Caput/presentation/widgets/util/input/textfield/caput_text_field.dart';
import 'package:Caput/presentation/widgets/util/input/buttons/caput_icon_button.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class FilterBottomInput extends StatefulWidget {
  final AnimationController animationController;

  const FilterBottomInput({super.key, required this.animationController});

  @override
  State<FilterBottomInput> createState() => _FilterBottomInputState();
}

class _FilterBottomInputState extends State<FilterBottomInput> {

  late Animation<double> rotationAnimation;
  late Animation<Color?> borderColorAnimation;
  late CaputTextEditingController textController;
  late NeuronsBloc neuronsBloc;
  late NeuronInputBloc neuronInputBloc;

  @override
  void initState() {
    super.initState();
    textController = CaputTextEditingController();
    neuronsBloc = context.read<NeuronsBloc>();
    neuronInputBloc = context.read<NeuronInputBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final inputTheme = Theme.of(context).inputDecorationTheme;

    final borderTween = Tween<Color>(
      begin: inputTheme.border!.borderSide.color,
      end: Colors.transparent,
    );

    borderColorAnimation = borderTween.animate(widget.animationController);

    final rotationTween = Tween<double>(
      begin: 0.0,
      end: 0.5,
    );

    rotationAnimation = rotationTween.animate(
      CurvedAnimation(
        curve: const Cubic(.36, -0.5, .5, 1.61),
        parent: widget.animationController,
      ),
    );

    void handleButtonUp() {
      //log("up");
      var controller = widget.animationController;
      if (controller.isCompleted) {
        controller.reverse();
        neuronInputBloc.add(NeuronInputCleanEvent());
      } else {
        controller.forward();
      }
    }

    final buttonUp = RotationTransition(
      turns: rotationAnimation,
      child: CaputIconButton(
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
          )),
    );

    void handleButtonAdd() {}
    final buttonAdd = CaputIconButton(
        icon: Icons.add, onPressed: () => handleButtonAdd());

    void handleButtonGo() {
      NeuronInputBloc neuronInputBloc = context.read<NeuronInputBloc>();
      neuronInputBloc.add(NeuronInputAddNeuronEvent());

      textController.clear();
      //widget.animationController.reverse();
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

    final Widget buildFilterScreenFooter = AnimatedBuilder(
      animation: borderColorAnimation,
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
                  children: [
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
        child: buildFilterScreenFooter),
    );
  }
}

Neuron getRandomNeuron() {
  Random random = Random();
  String userId = "e70b1b88-0b56-4ddf-9319-82480e3c5db7";
  DateTime now = DateTime.now();

  List<Tag> seedTags = [];
  List<Tag> tags = [];

  seedTags.add(Tag(
      tagId: "69680318-a67d-46d2-b91b-4b2f30482cde",
      userId: userId,
      creationTs: now,
      updateTs: now,
      caption: "arbeit",
      body: "Tag für alles was Arbeit betrifft"));
  seedTags.add(Tag(
      tagId: "d4bcd044-eeb6-4122-8f91-2b9a6fc33d8a",
      userId: userId,
      creationTs: now,
      updateTs: now,
      caption: "uni",
      body: "Tag für alles was Uni betrifft"));
  seedTags.add(Tag(
      tagId: "e70b1b88-0b36-4ddf-9317-82480e3c5db6",
      userId: userId,
      creationTs: now,
      updateTs: now,
      caption: "work",
      body: "Tag für alles was Work betrifft"));
  seedTags.add(Tag(
      tagId: "64b7d436-4d70-44fe-b036-a3ed58ad544f",
      userId: userId,
      creationTs: now,
      updateTs: now,
      caption: "freizeit",
      body: "Tag für alles was Freizeit betrifft"));
  seedTags.add(Tag(
      tagId: "1798969e-6da0-4cf8-9aa7-ebdffa1d4532",
      userId: userId,
      creationTs: now,
      updateTs: now,
      caption: "dj",
      body: "Tag für alles was DJ betrifft"));

  for (int i = 0; i < random.nextInt(5); i++) {
    tags.add(seedTags.elementAt(random.nextInt(seedTags.length)));
  }

  final faker = Faker();

  List<Payload> seedPayload = [];

  seedPayload
      .add(Note(type: "note", caption: faker.lorem.sentence(), priority: 1));
  seedPayload.add(Task(
      completed: false,
      deadlineTs: now.add(const Duration(days: 3)),
      type: "task",
      caption: faker.lorem.sentence(),
      priority: 1));
  seedPayload.add(Date(
      dateTs: now.add(const Duration(days: 20)),
      type: "date",
      caption: faker.lorem.sentence(),
      priority: 1));

  return Neuron(
      neuronId: const Uuid().v4().toString(),
      userId: userId,
      payload: seedPayload.elementAt(random.nextInt(3)),
      creationTs: DateTime.now(),
      updateTs: DateTime.now(),
      tags: tags);
}
