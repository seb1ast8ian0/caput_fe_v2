import 'dart:developer';

import 'package:Caput/presentation/screens/filter_screen/filter_screen.dart';
import 'package:Caput/presentation/screens/main_screen/main_screen_footer.dart';
import 'package:Caput/presentation/screens/main_screen/main_screen_header.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget{

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> filters = ["Alle Neuronen", "Alle Tasks", "Test"];

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
                    onPressed: (){log("new filter");}, 
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

                  double opacity;
                  LinearGradient gradient;
                  Color color;
                  BoxBorder border;

                    if(index==0) {
          
                      gradient =  LinearGradient(
                        colors: [Color.fromARGB(183, 77, 98, 232), CaputColors.colorBlue],
                        stops: const [0, 2],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      );
          
                      color = Colors.white;
                      opacity = 0.11;
                      border = Border.all(
                        color: Colors.transparent,
                        width: theme.border!.borderSide.width,
                      );
          
          
                    } else {
          
                      gradient = LinearGradient(
                        colors: [Theme.of(context).dialogBackgroundColor, Theme.of(context).dialogBackgroundColor],
                        stops: const [0, 1],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      );
          
                      color = Theme.of(context).brightness == Brightness.dark ? Colors.white : CaputColors.colorBlue;
                      opacity = 0;
                      border = Border.all(
                        color: theme.border!.borderSide.color,
                        width: theme.border!.borderSide.width,
                      );
          
                    }
          
                    return RawMaterialButton(
                      highlightElevation: 0,
                      elevation: 0,
                      
                      onPressed: () {
                        log("navigate to filter screen");
                        Navigator.push(context, MaterialPageRoute(builder: (_) => FilterScreen(filters[index])));
                      },
          
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: const AssetImage("assets/images/static_noise.jpeg"),
                            fit: BoxFit.cover,
                            opacity: opacity
                          ),
                          
                          gradient: gradient,
                          borderRadius: BorderRadius.circular(8),
                          border: border
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                filters[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: color
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: color
                              )
                            ],
                          ),
                        ),
                      ),
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

