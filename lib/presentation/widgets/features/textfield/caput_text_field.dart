import 'dart:developer';

import 'package:Caput/domain/bloc/neuron_input/neuron_input_bloc.dart';
import 'package:Caput/domain/bloc/tags_search/tags_search_bloc.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/main.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CaputTextField extends StatefulWidget {

  final CaputTextFieldController controller;

  const CaputTextField({required this.controller, super.key});

  @override
  State<CaputTextField> createState() => _CaputTextFieldState();
}

class _CaputTextFieldState extends State<CaputTextField> {

  late List<Word> words = [];
  late int cursor = 0;
  late Word currentWord = Element("", 0);

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

class WordWithDelta {
  Word word;
  int delta;

  WordWithDelta(this.word, this.delta);
}

class Element extends Word {
  Element(super.value, super.length);
}

class TagElement extends Word {
  TagElement(super.value, super.length);
}

abstract class Word {
  final String value;
  final int length;

  Word(this.value, this.length);

  @override
  String toString() {
    return value.toString();
  }
}

class CaputTextFieldController extends TextEditingController {

  int cursor = 0;
  Word currentWord = Element("", 0);
  List<Word> words = [];
  List<TextSpan> textSpans = [];
  int deltaToFirstLetter = 0;

  @override
  TextSpan buildTextSpan(
      {String? text,
      required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {

    final tagsSearchBloc = context.read<TagsSearchBloc>();
    final neuronInputBloc = context.read<NeuronInputBloc>();

    neuronInputBloc.add(NeuronInputSetTextEvent(super.text));

    cursor = super.selection.end;
    words = parseText(super.text);
    textSpans = getTextSpans(words);

    final wordWithDelta = getCurrentWordAndDelta(cursor, words);
    currentWord = wordWithDelta.word;
    deltaToFirstLetter = wordWithDelta.delta;

    /*
    log('cursor: $cursor');
    log('text: $words');
    log('currentWord: $currentWord');
    log('---');
    */

    if (currentWord is TagElement) {
      tagsSearchBloc.add(TagsSearchShowEvent(currentWord.value.substring(1)));
    } else {
      tagsSearchBloc.add(TagsSearchHideEvent());
    }

    return TextSpan(style: style, children: textSpans);

  }

  static List<String> getTagNames(List<Word> words){

    return words
      .whereType<TagElement>()
      .map((word) => word.value)
      .toList();

  }

  static List<Word> parseText(String text) {

    final List<Word> result = [];
    final List<String> wordsLineBreaks = text.split('\n');

    for (final line in wordsLineBreaks) {

      final List<String> words = line.split(' ');

      for (final item in words) {

        if (item.startsWith('#')) {

          final specialWord = TagElement(item, item.length);
          result.add(specialWord);

        } else if (item.isNotEmpty) {

          final regularWord = Element(item, item.length);
          result.add(regularWord);

        }

        result.add(Element(' ', 1));

      }

      result.removeLast();
      result.add(Element('\n', 1));

    }

    if (result.isNotEmpty) {
      // Entferne das letzte Leerzeichen oder Zeilenumbruch
      result.removeLast();
    }

    return result;
  }

  static WordWithDelta getCurrentWordAndDelta(int cursor, List<Word> words) {

    int length = 0;

    for (int i = 0; i < words.length; i++) {
      
      int startOfWord = length;
      int endOfWord = length + words.elementAt(i).length;

      if (cursor >= startOfWord && cursor <= endOfWord) {
        var delta = (startOfWord - cursor + 1);
        return WordWithDelta(words.elementAt(i), delta);
      }

      length += words.elementAt(i).length;

    }

    return WordWithDelta(Element("", 0), 0);

  }

  static List<TextSpan> getTextSpans(List<Word> words) {

    List<TextSpan> result = [];

    for (var word in words) {
      if (word is Element) {
        result.add(TextSpan(text: word.value));
      } else if (word is TagElement) {
        result.add(TextSpan(
          text: word.value,
          style: const TextStyle(color: CaputColors.colorBlue)
        ));
      }
    }
    return result;
  }

}
