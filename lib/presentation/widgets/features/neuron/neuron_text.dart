import 'package:Caput/presentation/widgets/util/input/textfield/caput_text_editing_controller.dart';
import 'package:flutter/cupertino.dart';

class NeuronText extends StatefulWidget {

  final String text;
  final TextStyle? style;
  final TextOverflow overflow;

  const NeuronText({required this.overflow, this.style, required this.text, super.key});

  @override
  State<NeuronText> createState() => _NeuronTextState();
}

class _NeuronTextState extends State<NeuronText> {

  late List<Word> words;
  late List<TextSpan> textSpans;

  @override
  void initState() {

    words = CaputTextEditingController.parseText(widget.text);
    textSpans = CaputTextEditingController.getTextSpans(words);
    
  }

  @override
  Widget build(BuildContext context) {

    return RichText(
      overflow: widget.overflow,
      text: TextSpan(
        style: widget.style, 
        children: textSpans
      )
    );

  }
}