
import 'dart:developer';

import 'package:Caput/domain/bloc/input_blocs/neuron_input/neuron_input_bloc.dart';
import 'package:Caput/domain/bloc/search_blocs/tags_search/tags_search_bloc.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaputTextEditingController extends TextEditingController {

  int cursor = 0;
  Word currentWord = TextElement("", 0);
  List<Word> words = [];
  List<TextSpan> textSpans = [];
  int deltaToFirstLetter = 0;

  @override
  TextSpan buildTextSpan({
    String? text,
    required BuildContext context,
    TextStyle? style,
    required bool withComposing
  }) {

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
    log('spans: $textSpans');
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

          final regularWord = TextElement(item, item.length);
          result.add(regularWord);

        }

        result.add(TextElement(' ', 1));

      }

      result.removeLast();
      result.add(TextElement('\n', 1));

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

    return WordWithDelta(TextElement("", 0), 0);

  }

  static List<TextSpan> getTextSpans(List<Word> words) {

    List<TextSpan> result = [];

    for (var word in words) {
      if (word is TextElement) {
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

class WordWithDelta {

  Word word;
  int delta;

  WordWithDelta(this.word, this.delta);

}

class TextElement extends Word {
  TextElement(super.value, super.length);
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

