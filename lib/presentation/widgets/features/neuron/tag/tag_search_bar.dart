import 'dart:developer';
import 'dart:ui';

import 'package:Caput/domain/controllers/tag_controller.dart';
import 'package:Caput/domain/entities/neuron/tag/tag.dart';
import 'package:Caput/main.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:uuid/uuid.dart';

class TagSearchBar extends StatefulWidget {

  final AnimationController animationController; 

  const TagSearchBar({required this.animationController, super.key});

  @override
  State<TagSearchBar> createState() =>  TagSearchBarState();

}

class TagSearchBarState extends State<TagSearchBar> {

  late bool isVisible  = false;
  late TagSearchEvent tagSearch = TagSearchEvent("", Future(() => []));
  late EventBus eventBus;
  late bool isLoading = true;
  late List<Tag> tags = [];


  Future<void> loadList() async {

    List<Tag> tagList = await tagSearch.tags;

    //log(tagList.toString());
    
    if(super.mounted){
      setState(() {
        tags = tagList;
        isLoading = false;
      });
    }
    
  }

  @override
  void initState() {

    
    eventBus = useEventBus(context);
    eventBus.on<TagSearchEvent>().listen((event) {

      if(super.mounted){
        setState(() {
          tagSearch = event;
          isVisible = !event.isEmpty;
        });
      }
      loadList();

    });
    

    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Visibility(
      visible: isVisible,
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor!.withOpacity(1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: Container(
                            color: CaputColors.colorBlue,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.search,
                                    size: 20,
                                    color: Colors.white
                                  ),
                                  const SizedBox(width: 4,),
                                  Container(
                                    constraints: const BoxConstraints(
                                      maxWidth: 50
                                    ),
                                    child: Text(
                                      tagSearch.query.isNotEmpty ? tagSearch.query.substring(1) : tagSearch.query,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        isLoading 
                        ? const Center(
                          child: CircularProgressIndicator(),
                        ) :
                        Expanded(
                          child: SizedBox(
                            height: 20,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: tags.length,
                              itemBuilder: (context, index) {
                                return SearchBarTag(tag: tags.elementAt(index));
                              }
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBarTag extends StatefulWidget {

  final Tag tag;

  const SearchBarTag({required this.tag, super.key});

  @override
  State<SearchBarTag> createState() => _SearchBarTagState();
  
}

class _SearchBarTagState extends State<SearchBarTag> {

  late EventBus eventBus;

  @override
  void initState() {

    //log(widget.tag.caption);
    eventBus = useEventBus(context);
    super.initState();

  }

  void onTagSelected(){

    var event = TagFeedbackEvent(widget.tag);
    eventBus.fire(event);

  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTagSelected,
      style: const ButtonStyle(
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 4
          )
        ),
      ),
      child: Text(
        '#${widget.tag.caption}',
        style: TextStyle(
          //fontSize: Theme.of(context).textTheme.
          fontSize: Theme.of(context).textTheme.titleSmall?.fontSize,
          fontWeight: FontWeight.w600
        ),
      )
    );
  }
}