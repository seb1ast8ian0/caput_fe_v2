import 'dart:ui';

import 'package:Caput/domain/bloc/search_blocs/tags_search/tags_search_bloc.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagSearchBar extends StatefulWidget {
  final AnimationController animationController;

  const TagSearchBar({required this.animationController, super.key});

  @override
  State<TagSearchBar> createState() => TagSearchBarState();
}

class TagSearchBarState extends State<TagSearchBar> {

  late bool isVisible = false;
  late List<Tag> tags = [];
  late String query = "";

  @override
  void initState() {

    super.initState();

  }

  @override
  void dispose() {

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<TagsSearchBloc, TagsSearchState>(
      listener: (context, state) {

        bool visibility = true;
        List<Tag> tagList = [];
        String queryString = "";

        if(state is TagsSearchHideState){
          visibility = false;
        } else if (state is TagsSearchShowState){
          tagList = state.rankedTags;
          queryString = state.query;
        }

        setState(() {
          isVisible = visibility;
          tags = tagList;
          query = queryString;
        });

      },
      child: Visibility(
        visible: isVisible,
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .appBarTheme
                          .backgroundColor!
                          .withOpacity(1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            child: Container(
                              color: CaputColors.colorBlue,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Row(
                                  children: [
                                    const Icon(Icons.search,
                                        size: 20, color: Colors.white),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 50),
                                      child: Text(
                                        query,
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
                          Expanded(
                            child: SizedBox(
                              height: 20,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: tags.length,
                                itemBuilder: (context, index) {
                                  return SearchBarTag(
                                      tag: tags.elementAt(index));
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


  @override
  void initState() {
    super.initState();
  }

  void onTagSelected() {
    final tagBloc = context.read<TagsSearchBloc>();
    tagBloc.add(TagsSearchFeedbackEvent(widget.tag));
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTagSelected,
        style: const ButtonStyle(
          padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(vertical: 0, horizontal: 4)),
        ),
        child: Text(
          '#${widget.tag.caption}',
          style: TextStyle(
              //fontSize: Theme.of(context).textTheme.
              fontSize: Theme.of(context).textTheme.titleSmall?.fontSize,
              fontWeight: FontWeight.w500,
              //color: Theme.of(context).textTheme.titleSmall?.color
            ),
        ));
  }

}
