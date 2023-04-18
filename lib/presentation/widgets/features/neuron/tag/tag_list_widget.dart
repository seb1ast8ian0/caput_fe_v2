import 'package:Caput/presentation/widgets/features/neuron/tag/tag_widget.dart';
import 'package:flutter/material.dart';


import 'package:Caput/domain/entities/neuron/tag/tag.dart';

class TagListWidget extends StatelessWidget {

final List<Tag> tags;

const TagListWidget({ Key? key, required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              for (var tag in tags) 
                TagWidget(tag: tag)
            ],
          ),
        ),
      ],
    );
  }
}