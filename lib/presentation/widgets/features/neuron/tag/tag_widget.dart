import 'dart:developer';

import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {

final Tag tag;

const TagWidget({ Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context){

    var chipTheme = Theme.of(context).chipTheme;


    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: TextButton(
        onPressed: (){log("tap on tag");}, 
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(chipTheme.backgroundColor),
          padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 0, horizontal: 4))
        ),
        child: Text(
          '#${tag.caption.toLowerCase()}',
          style: chipTheme.labelStyle
        ),
      ),
    );

  }
}