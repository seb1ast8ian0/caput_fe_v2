import 'dart:developer';

import 'package:Caput/domain/bloc/filter_input/filter_input_bloc.dart';
import 'package:Caput/domain/bloc/tags/tags_bloc.dart';
import 'package:Caput/domain/bloc/tags_search/tags_search_bloc.dart';
import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:Caput/presentation/widgets/util/input/buttons/caput_secondary_button.dart';
import 'package:Caput/presentation/widgets/util/input/caput_input_wrapper.dart';
import 'package:Caput/presentation/widgets/util/input/caput_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void showFilterInput(BuildContext context) {

  showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      constraints: const BoxConstraints(
        maxHeight: 600,
      ),
      isDismissible: true,
      barrierColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white12
          : Colors.black26,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.elliptical(16, 12),
          topRight: Radius.elliptical(16, 12),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (BuildContext context) {
        return const FilterInputScreen();
      });

}

class FilterInputScreen extends StatefulWidget {

  const FilterInputScreen({super.key});

  @override
  State<FilterInputScreen> createState() => _FilterInputScreenState();
}

class _FilterInputScreenState extends State<FilterInputScreen> {

  ValueNotifier<bool> showZeitNotifier = ValueNotifier<bool>(false);
  ValueNotifier<String> filterSearchText = ValueNotifier<String>("");

  Widget buildSubmitButton() {

    FilterInputBloc filterInputBloc = context.read<FilterInputBloc>();

    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          filterInputBloc.add(FilterInputAddFilterEvent());
          Navigator.pop(context);
        },
        elevation: 0,
        highlightElevation: 0,
        constraints: const BoxConstraints(minHeight: 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        fillColor: CaputColors.colorBlue,
        child: const Center(
          child: Text(
            "Hinzufügen",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
      ),
    );
  
  }

  Widget buildHeaderRow() {

    FilterInputBloc filterInputBloc = context.read<FilterInputBloc>();

    String filterCaption = "Neuer Filter";
    
    filterInputBloc.add(FilterInputSetTextEvent(filterCaption));

    return Row(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  log("photo");
                },
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: CaputColors.colorBlue.withOpacity(0.1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(40))),
                  child: Icon(CupertinoIcons.photo_camera,
                      color: CaputColors.colorBlue.withOpacity(1)),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  onChanged: (text) {
                    filterInputBloc.add(FilterInputSetTextEvent(text));
                  },
                  controller: TextEditingController(
                    text: filterCaption,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      color: CaputColors.colorBlue),
                ),
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: const EdgeInsets.all(0),
            constraints: BoxConstraints.tight(const Size.square(30)),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(
              Icons.close,
              size: 30,
              color: CaputColors.colorBlue,
            ))
      ],
    );
  }

  Widget buildTagInput() {

    TagsSearchBloc tagsSearchBloc = context.read<TagsSearchBloc>();
    FilterInputBloc filterInputBloc = context.read<FilterInputBloc>();

    return CaputInputWrapper(

        isEnabled: true,
        label: "Tags",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilterTextField(
              highlightColor: CaputColors.colorBlue,
              placeholder: "Suche Tag...",
              onChanged: (value) {
                filterSearchText.value = value;
                if(value.isNotEmpty){
                  tagsSearchBloc.add(TagsSearchShowEvent(value));
                }
              },
              leading: const Icon(Icons.search),
            ),
            ValueListenableBuilder(
              valueListenable: filterSearchText,
              builder: (context, value, child) {
                return FilterBarTagInput(
                  onTagSelected: (tags) {
                    filterInputBloc.add(FilterInputSetTagsEvent(tags));
                  },
                  searchString: value,
                );
              },
            ),
            const SizedBox(height: 8),
            CaputSelectableButtonWidget(
              expanded: true,
              gap: 8,
              isSingleSelect: true,
              onSelectionChanged: (buttons) {
                //log(buttons.toString());
              },
              buttons: [
                CaputSecondaryButton(
                  isSelected: true,
                  buttonKey: "or",
                  label: "oder",
                  icon: CupertinoIcons.arrow_up_left_arrow_down_right,
                  onPressed: () {
                    filterInputBloc.add(
                      FilterInputSetTagsOperatorEvent(LogicalOperator.or)
                    );
                  },
                  highlightColor: CaputColors.colorBlue),
                CaputSecondaryButton(
                  isSelected: false,
                  buttonKey: "and",
                  label: "und",
                  icon: CupertinoIcons.arrow_down_right_arrow_up_left,
                  onPressed: () {
                    filterInputBloc.add(
                      FilterInputSetTagsOperatorEvent(LogicalOperator.and)
                    );
                  },
                  highlightColor: CaputColors.colorBlue),
              ],
            ),
          ],
        ));
  }

  Widget buildTypeInput() {

    FilterInputBloc filterInputBloc = context.read<FilterInputBloc>();

    return CaputInputWrapper(
      isEnabled: true,
      label: "Types",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          CaputSelectableButtonWidget(
            expanded: true,
            gap: 8,
            isSingleSelect: false,
            onSelectionChanged: (buttons) {

              bool containsTaskOrDate = buttons.any((button) =>
                  button.buttonKey == "task" || button.buttonKey == "date");
              showZeitNotifier.value = containsTaskOrDate;

              List<NeuronType> types = [];

              types = buttons.map((button){
                if(button.buttonKey == "note"){
                  return NeuronType.note;
                } else if(button.buttonKey == "task"){
                  return NeuronType.task;
                } else {
                  return NeuronType.date;
                }
              }).toList();

              filterInputBloc.add(FilterInputSetTypesEvent(types));

            },
            buttons: [
              CaputSecondaryButton(
                isSelected: true,
                buttonKey: "note",
                label: "Notiz",
                icon: CupertinoIcons.doc,
                onPressed: () {},
                highlightColor: CaputColors.colorBlue,
              ),
              CaputSecondaryButton(
                isSelected: false,
                buttonKey: "task",
                label: "Aufgabe",
                icon: Icons.check,
                onPressed: () {},
                highlightColor: CaputColors.colorBlue,
              ),
              CaputSecondaryButton(
                isSelected: false,
                label: "Termin",
                buttonKey: "date",
                icon: Icons.calendar_today_rounded,
                onPressed: () {},
                highlightColor: CaputColors.colorBlue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTimeInput() {

    FilterInputBloc filterInputBloc = context.read<FilterInputBloc>();

    return ValueListenableBuilder<bool>(
      valueListenable: showZeitNotifier,
      builder: (context, value, child) {
        return CaputInputWrapper(
            isEnabled: value,
            label: "Zeit",
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: CaputSelectableButtonWidget(
                    onSelectionChanged: (buttons) {

                      String buttonKey = buttons[0].buttonKey;
                      DateOption option = DateOption.all;

                      if(buttonKey == "today"){
                        option = DateOption.today;
                      } else if(buttonKey == "tomorrow"){
                        option = DateOption.tomorrow;
                      } else if(buttonKey == "week"){
                        option = DateOption.oneWeek;
                      } else if(buttonKey == "month") {
                        option = DateOption.oneMonth;
                      }
                    
                      filterInputBloc.add(FilterInputSetTimeEvent(option));

                    },
                    isSingleSelect: true,
                    gap: 8,
                    buttons: [
                      CaputSecondaryButton(
                        isSelected: true,
                        buttonKey: "all",
                        label: "Alle",
                        onPressed: () {},
                        highlightColor: CaputColors.colorBlue,
                      ),
                      CaputSecondaryButton(
                        isSelected: false,
                        buttonKey: "today",
                        label: "Heute",
                        onPressed: () {},
                        highlightColor: CaputColors.colorBlue,
                      ),
                      CaputSecondaryButton(
                        isSelected: false,
                        buttonKey: "tomorrow",
                        label: "Morgen",
                        onPressed: () {},
                        highlightColor: CaputColors.colorBlue,
                      ),
                      CaputSecondaryButton(
                        isSelected: false,
                        buttonKey: "week",
                        label: "1 Woche",
                        onPressed: () {},
                        highlightColor: CaputColors.colorBlue,
                      ),
                      CaputSecondaryButton(
                        isSelected: false,
                        buttonKey: "month",
                        label: "1 Monat",
                        onPressed: () {},
                        highlightColor: CaputColors.colorBlue,
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 0, 16, MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 20),
          buildHeaderRow(),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  buildTagInput(),
                  const SizedBox(height: 16),
                  buildTypeInput(),
                  const SizedBox(height: 16),
                  buildTimeInput(),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [buildSubmitButton()],
                ),
                const SizedBox(height: 8)
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }

}

// ignore: must_be_immutable
class FilterBarTagInput extends StatefulWidget {

  String? searchString;
  Function(List<Tag>) onTagSelected;

  FilterBarTagInput({
    this.searchString = "", 
    required this.onTagSelected,
    super.key
  });

  @override
  State<FilterBarTagInput> createState() => _FilterBarTagInputState();

}

class _FilterBarTagInputState extends State<FilterBarTagInput> {

  late Set<Tag> selectedTags;
  late List<Tag> tags;
  late List<Tag> filteredTags;

  @override
  void initState() {

    log("init");

    TagsList tagsList = Get.find();
    tags = List.of(tagsList.getTags());

    selectedTags = Set();
    filteredTags = [];

    log(tags.toString());
    
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<TagsSearchBloc, TagsSearchState>(
      listener: (context, state) {
        if(state is TagsSearchShowState){

          List<Tag> cleanTags = List.of(state.rankedTags);
          cleanTags.removeWhere((tag) => selectedTags.contains(tag));

          setState(() {
            filteredTags = cleanTags;
          });
        }
      },
      child: Container(
          constraints: const BoxConstraints(maxHeight: 34),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                if (widget.searchString != "")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.transparent,
                        child: CaputSelectableButtonWidget(
                            gap: 8,
                            buttons: filteredTags.map((tag) {
                              return FilterBarTag(
                                onPressed: () {
                                  selectTag(tag);
                                },
                                isSelected: false,
                                buttonKey: tag.caption,
                                tag: tag);
                            }).toList(),
                            onSelectionChanged: (value) {}),
                      ),
                    ],
                  ),
                if (widget.searchString == "")
                  Row(
                    children: [
                      CaputSelectableButtonWidget(
                          gap: 8,
                          buttons: selectedTags.map((tag) {
                            return FilterBarTag(
                                onPressed: () {
                                  removeTag(tag);
                                },
                                isSelected: true,
                                buttonKey: tag.caption,
                                tag: tag);
                          }).toList(),
                          onSelectionChanged: (value) {}),
                      if (selectedTags.isNotEmpty)
                        const SizedBox(
                          width: 8,
                        ),
                      CaputSelectableButtonWidget(
                          gap: 8,
                          buttons: tags.map((tag) {
                            return FilterBarTag(
                                onPressed: () {
                                  selectTag(tag);
                                },
                                isSelected: false,
                                buttonKey: tag.caption,
                                tag: tag);
                          }).toList(),
                          onSelectionChanged: (value) {}),
                    ],
                  ),
              ],
            ),
          )),
    );
  
  }

  void selectTag(Tag tag) {

    //log("select Tag: ${tag.caption}");

    setState(() {
      selectedTags.add(tag);
      filteredTags.remove(tag);
      tags.remove(tag);
    });

    widget.onTagSelected(selectedTags.toList());

  }

  void removeTag(Tag tag) {

    //log("remove Tag: ${tag.caption}");

    setState(() {
      tags.add(tag);
      selectedTags.remove(tag);
    });

    widget.onTagSelected(selectedTags.toList());

  }

}

class FilterBarTag extends StatelessWidget implements CaputSelectableButton {
  
  final Tag tag;
  final Function() onPressed;

  @override
  bool isSelected;

  @override
  String buttonKey;

  FilterBarTag(
      {required this.tag,
      required this.buttonKey,
      required this.isSelected,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return buildButton(context, onPressed);
  }

  @override
  Widget buildButton(BuildContext context, VoidCallback onPressed) {
    final inputTheme = Theme.of(context).inputDecorationTheme;
    var themeColor = inputTheme.hintStyle!.color!;
    var highlightColor = CaputColors.colorBlue;

    Color color = isSelected ? highlightColor : themeColor;
    Color backgroundColor =
        isSelected ? highlightColor.withOpacity(0.1) : inputTheme.fillColor!;

    return Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          splashColor: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            onPressed();
            this.onPressed();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Text(
              "#${tag.caption}",
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ));
  }
}

class FilterTextField extends StatefulWidget {
  Color highlightColor;
  String placeholder;
  Function(String) onChanged;
  Widget? leading;

  FilterTextField(
      {super.key,
      this.leading,
      required this.highlightColor,
      required this.placeholder,
      required this.onChanged});

  @override
  State<FilterTextField> createState() => _FilterTextFieldState();
}

class _FilterTextFieldState extends State<FilterTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            widget.leading ?? Container(),
            if (widget.leading != null)
              const SizedBox(
                width: 10,
              )
          ],
        ),
        Expanded(
          child: TextField(
            onChanged: (value) {
              widget.onChanged(value);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: widget.placeholder,
            ),
          ),
        ),
      ],
    );
  }
}
