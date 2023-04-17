import 'dart:developer';
import 'dart:ui';

import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/material.dart';

class SettingsAppBar extends StatefulWidget implements PreferredSizeWidget{
  
  
  const SettingsAppBar({super.key});

  
  @override
  State<SettingsAppBar> createState() => _SettingsAppBarState();
  
  @override
    Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SettingsAppBarState extends State<SettingsAppBar> {

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
        appBarBackgroundColor = (Theme.of(context).appBarTheme.backgroundColor as Color).withOpacity(0.4);
    } else {
        appBarBackgroundColor = Theme.of(context).appBarTheme.backgroundColor as Color;
    }


    var theme = Theme.of(context).inputDecorationTheme;

    Widget appBarContent = Container(
      decoration: BoxDecoration(
        color: appBarBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: theme.border!.borderSide.color,
            width: theme.border!.borderSide.width
          ),
        ),
      ),
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
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
                        log("navigate back");
                        Navigator.pop(context);
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    const Text(
                      "Einstellungen",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
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
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: appBarContent,
        ),
      );
    }
    
    return appBarContent;
  }

}

