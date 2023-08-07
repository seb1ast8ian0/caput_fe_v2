import 'dart:developer';

import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/presentation/screens/filter_input_screen/filter_input_screen.dart';
import 'package:Caput/presentation/screens/filter_screen/filter_screen.dart';
import 'package:Caput/presentation/screens/main_screen/main_screen_footer.dart';
import 'package:Caput/presentation/screens/main_screen/main_screen_header.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget{

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> filters = ["Alle Tasks", "Test", "Inbox",
              "Wichtig", "Erledigt", "Projekte", "Einkaufsliste", "Notizen",
              "Fotos", "Archiv", "Entwürfe", "Kalender", "Kontakte"];

    final searchController = TextEditingController();
    final theme = Theme.of(context).inputDecorationTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const MainAppBar(),
          SliverPersistentHeader(
            pinned: false,
            floating: false,
            delegate: _SliverAppBarDelegate(
              minHeight: 50.0,
              maxHeight: 52.0,
              child: Container(
                color: Theme.of(context).appBarTheme.backgroundColor!.withOpacity(0.6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                    fontSize: 14
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: "Suche...",
                                    hintStyle: theme.hintStyle,
                                    border: InputBorder.none
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.search, 
                                color: theme.hintStyle!.color
                              )
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: (){
                      //log("new filter");
                      showFilterInput(context);
                    }, 
                    label: const Text("Neuer Filter", 
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero)
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            sliver: SliverList(
              
              delegate: SliverChildBuilderDelegate(

                (BuildContext context, int index) {

                  Color color = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87;
                
                  return Column(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(30),
                        splashFactory: InkSplash.splashFactory,
                        /*onLongPress: () {
                          log("long");
                        },*/
                        onTap: (){
                          Filter filter = Filter(
                            filterId: "filterId", 
                            userId: "userId", 
                            caption: filters[index], 
                            creationTs: DateTime.now(), 
                            updateTs: DateTime.now(), 
                            tags: [], 
                            tagsOperator: LogicalOperator.or,
                            neuronTypes: [], 
                            dateOption: DateOption.all
                          );
                          log("navigate to filter: ${filter.caption}");
                          Navigator.push(context, MaterialPageRoute(builder: (_) => FilterScreen(filter)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: CaputColors.colorBlue,
                                    width: 2
                                  ),
                                  borderRadius: BorderRadius.circular(36),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.left,
                                      filters[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: color,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    const Text(
                                      "Inhalt (Cation of latest Neuron) bla bla bla ich werde jetzt mehr schreiben als das Teil lang ist und noch vieeel mehr",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: color
                              ),
                              const SizedBox(
                                width: 12,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                childCount: filters.length,
              ),
            ),
          ),
        
        ]
      ),
      bottomNavigationBar: const MainNavBar()
    
    );

  }
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

