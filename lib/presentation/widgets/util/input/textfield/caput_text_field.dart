import 'package:Caput/domain/bloc/search_blocs/tags_search/tags_search_bloc.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/presentation/widgets/util/input/textfield/caput_text_editing_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaputTextField extends StatefulWidget {

  final CaputTextEditingController controller;

  const CaputTextField({required this.controller, super.key});

  @override
  State<CaputTextField> createState() => _CaputTextFieldState();

}

class _CaputTextFieldState extends State<CaputTextField> {

  late List<Word> words = [];
  late int cursor = 0;
  late Word currentWord = TextElement("", 0);

  @override
  void initState() {
    super.initState();
  }

  void updateTag(Tag tag) {

    int cursor = widget.controller.cursor;
    int delta = widget.controller.deltaToFirstLetter;

    //if < 0 -> out of bounds
    int startofWord = (cursor + delta) < 0 ? 0 : (cursor + delta);
    int endOfWord = (cursor + (widget.controller.currentWord.length + delta) - 1) < 0 ? 0 : (cursor + (widget.controller.currentWord.length + delta) - 1);

    String text = widget.controller.text;

    String startToWord = text.substring(0, startofWord);
    String wordToEnd = text.substring(endOfWord, text.length);
    String word = wordToEnd.startsWith(' ') ? tag.caption : '${tag.caption} ';

    widget.controller.text = startToWord + word + wordToEnd;

    int offset = startToWord.length + word.length;
    widget.controller.selection = TextSelection(baseOffset: offset, extentOffset: offset);

  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<TagsSearchBloc, TagsSearchState>(

      listener: (context, state) {
        if(state is TagsSearchFeedbackState){
          updateTag(state.tag);
        }
      },
      child: TextField(
        enableInteractiveSelection: true,
        textCapitalization: TextCapitalization.sentences,
        controller: widget.controller,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 5,
        style: Theme.of(context).textTheme.titleSmall,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 6, 
            horizontal: 12
          ), //vertical: 12 on other devices
          hintText: "Neues Neuron...",
          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
          border: InputBorder.none
        ),
      ),
    );
  }

}
