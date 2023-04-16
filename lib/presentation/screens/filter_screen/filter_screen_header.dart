
import 'dart:ui';

import 'package:Caput/presentation/util/colors/caput_colors.dart';
import 'package:flutter/material.dart';

class FilterAppBar extends StatefulWidget implements PreferredSizeWidget{
  
  final String title;
  
  const FilterAppBar(this.title, {super.key});

  
  @override
  State<FilterAppBar> createState() => _FilterAppBarState();
  
  @override
    Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FilterAppBarState extends State<FilterAppBar> {
  
  _FilterAppBarState();

  ScrollNotificationObserverState? _scrollNotificationObserver;
  bool _scrolledUnder = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollNotificationObserver?.removeListener(_handleScrollNotification);
    _scrollNotificationObserver = ScrollNotificationObserver.maybeOf(context);
    _scrollNotificationObserver?.addListener(_handleScrollNotification);
  }

  @override
  void dispose() {
    if (_scrollNotificationObserver != null) {
      _scrollNotificationObserver!.removeListener(_handleScrollNotification);
      _scrollNotificationObserver = null;
    }
    super.dispose();
  }

  void _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final bool oldScrolledUnder = _scrolledUnder;
      final ScrollMetrics metrics = notification.metrics;
      switch (metrics.axisDirection) {
        case AxisDirection.up:
          // Scroll view is reversed
          _scrolledUnder = metrics.extentAfter > 0;
          break;
        case AxisDirection.down:
          _scrolledUnder = metrics.extentBefore > 0;
          break;
        case AxisDirection.right:
        case AxisDirection.left:
          // Scrolled under is only supported in the vertical axis.
          _scrolledUnder = false;
          break;
      }

      if (_scrolledUnder != oldScrolledUnder) {
        setState(() {
          // React to a change in MaterialState.scrolledUnder
        });
      }
    }

  }

  @override
  Widget build(BuildContext context) {

    Color appBarBackgroundColor;

    if(_scrolledUnder){
        appBarBackgroundColor = CaputColors.colorAppBarBackgroundLight.withOpacity(0.4);
    } else {
        appBarBackgroundColor = CaputColors.colorAppBarBackgroundLight;
    }

    Widget appBarContent = Container(
      decoration: BoxDecoration(
        color: appBarBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: CaputColors.colorLightGrey.withOpacity(0.6),
            width: 0.4,
          ),
        ),
      ),
      child: SafeArea(
        child: Material(
          color: appBarBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  [
                    IconButton(
                      constraints: BoxConstraints.tight(const Size.square(38)),
                      iconSize: 24,
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: CaputColors.colorBlue, 
                      onPressed: (){
                        print("navigate");
                        Navigator.pop(context);
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    Text(
                        widget.title.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                          color: CaputColors.colorBlue
                        ),
                      ),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );


    if(_scrolledUnder){
      appBarContent = ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: appBarContent,
        ),
      );
    }
    
    return appBarContent;
  }

}

