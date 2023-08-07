import 'package:Caput/presentation/widgets/features/textfield/caput_text_field.dart';
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

  @override
  Widget build(BuildContext context) {

    final words = CaputTextFieldController.parseText(widget.text);
    final textSpans = CaputTextFieldController.getTextSpans(words);

    return RichText(
      overflow: widget.overflow,
      text: TextSpan(
        style: widget.style, 
        children: textSpans
      )
    );

  }
}