import 'dart:developer';

import 'package:Caput/domain/bloc/data_blocs/filter/filters_bloc.dart';
import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/presentation/screens/filter_input_screen/filter_input_screen.dart';
import 'package:Caput/presentation/screens/filter_screen/filter_screen.dart';
import 'package:Caput/presentation/screens/main_screen/main_screen_footer.dart';
import 'package:Caput/presentation/screens/main_screen/main_screen_header.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late FiltersBloc filtersBloc;

  @override
  void initState() {
    filtersBloc = context.read<FiltersBloc>();
  }

  @override
  Widget build(BuildContext context) {
    filtersBloc.add(const GetFiltersEvent());

    final searchController = TextEditingController();
    final theme = Theme.of(context).inputDecorationTheme;

    return Scaffold(
        body: CustomScrollView(slivers: [
          const MainAppBar(),
          SliverPersistentHeader(
            pinned: false,
            floating: false,
            delegate: _SliverAppBarDelegate(
              minHeight: 50.0,
              maxHeight: 52.0,
              child: Container(
                color: Theme.of(context)
                    .appBarTheme
                    .backgroundColor!
                    .withOpacity(0.6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: theme.fillColor,
                          border: Border.all(
                            color: theme.border!.borderSide.color,
                            width: theme.border!.borderSide.width,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(fontSize: 14),
                                  decoration: InputDecoration(
                                      isDense: true,
                                      hintText: "Suche...",
                                      hintStyle: theme.hintStyle,
                                      border: InputBorder.none),
                                ),
                              ),
                              Icon(Icons.search, color: theme.hintStyle!.color)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      //log("new filter");
                      showFilterInput(context);
                    },
                    label: const Text(
                      "Neuer Filter",
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero)),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              sliver: BlocBuilder<FiltersBloc, FilterState>(
                builder: (context, state) {
                  log(state.status.toString());
                  if(state.status == FilterStateStatus.success){
                    return _buildList(state.filters);
                  }
                  return _buildList(state.filters);
                },
              )),
        ]),
        bottomNavigationBar: const MainNavBar());
  }

  Widget _buildList(List<Filter> filters) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: filters.length,
        (BuildContext context, int index) {
          Color color = Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black87;

          return Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(0),
                splashFactory: InkSplash.splashFactory,
                /*
                focusColor: color.withOpacity(0.05),
                splashColor: color.withOpacity(0.05),
                onLongPress: () {
                  log("long");
                },*/
                onTap: () {
                  print("navigate to filter: ${filters[index].caption}");
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (_) => FilterScreen(
                        caption: filters[index].caption,
                        filterId: filters[index].filterId,
                      )
                    )
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: CaputColors.colorBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.collections,
                            color: color.withOpacity(0.5),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              textAlign: TextAlign.left,
                              filters[index].caption,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: color,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              filters[index].neuronTypes.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Icon(Icons.arrow_forward_ios,
                              size: 18, color: color),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /*
  Color generateRandomPastelColor() {
    final random = Random();

    // Generate a random hue in the range [0, 360)
    final hue = random.nextDouble() * 360.0;

    // Set a fixed saturation and lightness for pastel colors
    final saturation = 0.4 + random.nextDouble() * 0.4; // Range: [0.4, 0.8]
    final lightness = 0.6 + random.nextDouble() * 0.2; // Range: [0.6, 0.8]

    // Create the color using HSL color model
    return HSLColor.fromAHSL(0.4, hue, saturation, lightness).toColor();
  }
  */
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
