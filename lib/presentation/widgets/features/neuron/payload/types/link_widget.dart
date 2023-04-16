import 'package:Caput/domain/entities/neuron.dart';
import 'package:Caput/domain/entities/payloads/Link.dart';
import 'package:Caput/presentation/util/colors/caput_colors.dart';
import 'package:Caput/presentation/widgets/features/neuron/status/status_widget.dart';
import 'package:flutter/material.dart';

class LinkWidget extends StatelessWidget{

  final Neuron neuron;
  final int index;
  

  const LinkWidget({super.key, required this.index, required this.neuron});
  
  @override
  Widget build(BuildContext context) {

  Link link;
  
  if(neuron.payload is Link){
      link = neuron.payload as Link;
  } else {
    return const Text("error");
  }

  String displayTime = neuron.getCreationDateAsString();

  Widget noteContent = IntrinsicHeight(

    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        StaticStatusWidget(CaputColors.colorLightGrey),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        link.caption,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: CaputColors.colorTextPrimaryLight
                        ),
                      ),
                      Text(
                        displayTime,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: CaputColors.colorTextSecondaryLight
                        ),
                        )
                    ],
                  ),
                ),
                
                if(link.body != "")
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Text(
                      link.body,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: CaputColors.colorTextSecondaryLight
                      ),
                    ),
                  ),
                 
                const SizedBox(height: 4),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(4),
                          color: CaputColors.colorGrey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
                            child: Text(
                              link.urlTitle,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            )
          ),
        )
      ],
    ),

  );


  return noteContent;

  }

  /*
  _launchURL() async {
    const url = 'https://flutter.io';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
  */

}