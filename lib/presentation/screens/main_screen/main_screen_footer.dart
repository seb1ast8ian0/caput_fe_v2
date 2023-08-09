import 'dart:developer';

import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/presentation/screens/filter_screen/filter_screen.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:Caput/presentation/widgets/util/input/buttons/caput_primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainNavBar extends StatelessWidget{

  const MainNavBar({super.key});

  @override
  Widget build(BuildContext context) {

    Widget buildAllNeuronsButton(){
      return Row(
        children: [
          RawMaterialButton(
            onPressed: (){},
            constraints: const BoxConstraints(
              minHeight: 40,
              minWidth: 40
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            ),
            fillColor: Colors.orange,
            elevation: 0,
            highlightElevation: 0,
            child: const Icon(
              CupertinoIcons.sparkles,
              color: Colors.white,
            )
          ),
          const SizedBox(width: 4),
          Expanded(
            child: CaputPrimaryButton(
              label: "Alle Neuronen", 
              color: CaputColors.colorBlue, 
              onPressed: (){
                Filter emptyFilter = Filter(
                  filterId: "filterId", 
                  userId: "userId", 
                  caption: "Alle Neuronen", 
                  creationTs: DateTime.now(), 
                  updateTs: DateTime.now(), 
                  tags: [], 
                  tagsOperator: LogicalOperator.or,
                  neuronTypes: [], 
                  dateOption: DateOption.all
                );
                log("navigate to filter: ${emptyFilter.caption}");
                Navigator.push(context, MaterialPageRoute(builder: (_) => FilterScreen(emptyFilter)));
              }
            )
          ),
        ],
      );
    }

    return Stack(
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).scaffoldBackgroundColor, // Schattenfarbe und Transparenz
                  offset: const Offset(0, 10), // Verschiebung des Schattens nach oben (negative y-Richtung)
                  blurRadius: 20, // Radius des Schattens
                  spreadRadius: 30
                ),
              ],
              borderRadius: BorderRadius.circular(10), // Radius der Ecken des Containers
              color: Theme.of(context).scaffoldBackgroundColor // Hintergrundfarbe des Containers
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildAllNeuronsButton(),
            )
          ),
        ],
      );
  }

}