import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/material.dart';

class DynamicStatusWidget extends StatefulWidget{

  final DateTime start;
  final DateTime end;
  final Color? color;
  final Function(Color) onHighlightColorChanged;
  

  const DynamicStatusWidget({super.key, required this.start, required this.end, this.color, required this.onHighlightColorChanged});

  @override
  State<DynamicStatusWidget> createState() => _DynamicStatusWidgetState();

}

class _DynamicStatusWidgetState extends State<DynamicStatusWidget> with TickerProviderStateMixin {

  late Color highlightColor;
  late Duration _distanceWhole;
  late Duration _distanceLeft;
  late double _timeRatio;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    highlightColor = CaputColors.colorBlue;
    _calculate();

    _animationController =  AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {
          _calculate();
        });
        widget.onHighlightColorChanged(highlightColor);
      });

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    return Material(
      borderRadius: BorderRadius.circular(0),//3
      //color: Theme.of(context).progressIndicatorTheme.color,
      color: highlightColor.withOpacity(0.2),
      elevation: 0,
      child: Column(
        verticalDirection: VerticalDirection.up,
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),//3
              child: Container(
                color: highlightColor,
                width: 4,
                child: FractionalTranslation(
                  translation: Offset(0, 1 - _timeRatio),
                  child: FractionallySizedBox(
                    heightFactor: _timeRatio,
                    child: Container(
                      color: highlightColor,
                      width: 4,
                    ),
                  ),
                ),
              ),
            )
          )
        ],
      )
    );
    
  }

  void _calculate() {

  setState(() {

    _distanceWhole = widget.end.difference(widget.start);
    _distanceLeft = widget.end.difference(DateTime.now());
    
    _timeRatio =  (_distanceWhole - _distanceLeft).inSeconds / _distanceWhole.inSeconds;
    
    
    if(_timeRatio <= 0.1){
      _timeRatio = 0.1;
    }

    if(widget.color == null){

      if(_timeRatio <= 0.5 && _timeRatio >= 0){
        highlightColor = CaputColors.colorGreen;
      } else if(_timeRatio < 0.85 && _timeRatio >= 0.5){
        highlightColor = CaputColors.colorOrange;
      } else if(_timeRatio >= 0.85){
        highlightColor = CaputColors.colorRed;
      }

    } else {

      highlightColor = widget.color as Color;

    }

  } 
  );

  }
    

  
}

class StaticStatusWidget extends StatelessWidget {

  final Color color;

  const StaticStatusWidget(this.color, {super.key});
    
  @override
  Widget build(BuildContext context) {
    
    return Material(
      borderRadius: BorderRadius.circular(0),//3
      color: color,
      elevation: 0,
      child: Column(
        verticalDirection: VerticalDirection.up,
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),//3
              child: Container(
                color: color,
                width: 4,
                child: const FractionallySizedBox(
                  heightFactor: 1,
                ),
              ),
            )
          )
        ],
      )
    );
  }   

}