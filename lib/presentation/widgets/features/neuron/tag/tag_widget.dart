import 'dart:developer';

import 'package:Caput/domain/entities/neuron/tag/tag.dart';
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

    /*
    return ClipRRect(
      child: ActionChip(
        label: Text('#${tag.caption.toLowerCase()} ', style: TextStyle(),), 
        onPressed: (){log("na");},
        labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        padding: EdgeInsets.zero,
      ),
    );

    */
    
    /*Material(
      color: CaputColors.colorLightGrey.withOpacity(0.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      child: TextButton(
        onPressed: (){}, 
        style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 0, horizontal: 4))),
        child: Text('#${tag.caption.toLowerCase()} ', style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.titleSmall?.color),),
      )
    );*/
  }
}