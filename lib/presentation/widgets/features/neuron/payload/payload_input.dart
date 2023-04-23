import 'dart:developer';
import 'dart:ui';

import 'package:Caput/domain/entities/neuron/payload/Payload.dart';
import 'package:Caput/domain/entities/neuron/payload/payloads/Date.dart';
import 'package:Caput/domain/entities/neuron/payload/payloads/Note.dart';
import 'package:Caput/domain/entities/neuron/payload/payloads/Task.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PayloadInput extends StatefulWidget {

  final AnimationController animationController;
  final ScrollController scrollController;

  final Function(Payload) onPayloadChanged;

  /*

  widget.scrollController.animateTo(0, duration: Duration(milliseconds: 200), curve: Curves.bounceInOut);

  */

  const PayloadInput({Key? key, required this.onPayloadChanged, required this.animationController, required this.scrollController}) : super(key: key);

  @override
  PayloadInputState createState() => PayloadInputState();

}

class PayloadInputState extends State<PayloadInput> with TickerProviderStateMixin {

  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;
  
  late Payload _payload;
  Widget _payloadBody = Container();

  double _height = 0;
  int _col = 0;
  bool _inputIsHidden = true;

  @override
  void initState() {

    super.initState();

    _offsetAnimation =
      Tween<Offset>(
        begin: const Offset(0.0, 0.6), 
        end: Offset.zero
      ).animate(
          CurvedAnimation(
            parent: widget.animationController, 
            curve: Curves.easeInOutSine
          )
      );

    _opacityAnimation = CurvedAnimation(
      parent: widget.animationController, 
      curve: Curves.elasticInOut
    );

    widget.animationController.addListener(() {

      var status = widget.animationController.status;
      
      if(status == AnimationStatus.forward || status == AnimationStatus.completed){
        setState(() {
          _inputIsHidden = false;
        });
      }

      if(status == AnimationStatus.reverse || status == AnimationStatus.dismissed){
        setState(() {
          _inputIsHidden = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _offsetAnimation,
        child: IgnorePointer(
          ignoring: _inputIsHidden,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                color: Color.fromARGB(67, 179, 179, 179),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor!.withOpacity(0.6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                       
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              PayloadInputButton(
                                _col == 1,
                                Icons.check, 
                                () {
                                  _payload = Task("", false, DateTime.now().add(const Duration(minutes: 1)), "task", "", 1);
                                  _save();
                                  _toogle(1);
                                  setState(() {
                                    _payloadBody = _buildTaskInput();
                                  });
                                }
                              ),
                              const SizedBox(width: 8),
                              PayloadInputButton(
                                _col == 2,
                                Icons.calendar_today_rounded, 
                                () {
                                  _payload = Date("", DateTime.now().add(const Duration(days: 2)), "date", "", 1);
                                  _save();
                                  _toogle(2);
                                  setState(() {
                                    _payloadBody = _buildDateInput();
                                  });
                                }
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOutSine,
                        constraints: BoxConstraints(maxHeight: _height),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: SingleChildScrollView(
                            child:  _payloadBody
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  
  }

  _save(){
    widget.onPayloadChanged(_payload);
  }

  _toogle(int col){

    setState(() {
      if(_col == 0){
        _height = 300;
        _col = col;
      } else if(_col == col){
          _payload = Note("", "note", "", 1);
          _save();
        if(_height == 0){
          _height = 300;
        } else {
          _height = 0;
          _col = 0;
        } 
      } else {
        _col = col;
      }
    });

  }

  bool _isTask(Payload payload){
    return payload is Task;
  }

  Widget _buildTaskInput(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.all(0.0),
            child: Text(
              "Deadline:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: CaputColors.colorBlue
              ),
            ),
          ),
          
          PayloadDateTimeInput(
            onTimeChanged:(time) {
              log(time.toString());
              if(_isTask(_payload)){
                var task = _payload as Task;
                task.deadlineTs = time;
                _payload = task;
                _save();
              }
            },
          ),
          
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(0.0),
            child: Text(
              "Body: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: CaputColors.colorBlue
              ),
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(0.0),
            child: Text(
              "Tags: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: CaputColors.colorBlue
              ),
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(0.0),
            child: Text(
              "Priorität: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: CaputColors.colorBlue
              ),
            ),
          ),
          const SizedBox(height: 4)
      ],
    );
  }

  bool _isDate(Payload payload){
    return payload is Date;
  }

  Widget _buildDateInput(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.all(0.0),
            child: Text(
              "Termin:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: CaputColors.colorBlue
              ),
            ),
          ),
          
          PayloadDateTimeInput(
            onTimeChanged:(time) {
              log(time.toString());
              if(_isDate(_payload)){
                var date = _payload as Date;
                date.dateTs = time;
                _payload = date;
                _save();
              }
            },
          ),
          
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(0.0),
            child: Text(
              "Body: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: CaputColors.colorBlue
              ),
            ),
          ),
          
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(0.0),
            child: Text(
              "Tags: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: CaputColors.colorBlue
              ),
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(0.0),
            child: Text(
              "Priorität: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: CaputColors.colorBlue
              ),
            ),
          ),
          const SizedBox(height: 4),
      ],
    );
  }

}

class PayloadInputButton extends StatelessWidget{

  final IconData icon;
  final Function()? onPressed;
  final bool isHighlighted;

  const PayloadInputButton(this.isHighlighted, this.icon, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {

    var borderTheme = Theme.of(context).inputDecorationTheme;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),

          image: const DecorationImage(
            image: AssetImage("assets/images/static_noise.jpeg"),
            fit: BoxFit.cover,
            opacity: 0.1
          ),
          
          border: Border.all(
              color: isHighlighted ? CaputColors.colorBlue : borderTheme.border!.borderSide.color,
              width: borderTheme.border!.borderSide.width,
          ),

        ),
        child: InkWell(
            splashColor: Colors.grey[600],
            highlightColor: Colors.grey[400],
            onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Icon(
              icon,
              size: 24.0,
              color: CaputColors.colorBlue,
            ),
          ),
        ),
      ),
    );
  }

}

class PayloadDateTimeInput extends StatefulWidget {

  final Function(DateTime) onTimeChanged;

  const PayloadDateTimeInput({ required this.onTimeChanged, Key? key }) : super(key: key);

  @override
  _PayloadDateTimeInputState createState() => _PayloadDateTimeInputState();
}

class _PayloadDateTimeInputState extends State<PayloadDateTimeInput> {

  int _num = 0;
  double _height = 0;
  DateTime _time = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _toggle(int num){
    setState(() {
      if(_num == num){
        if(_height == 0){
          _num = num;
          _height = 150;
        } else {
          _height = 0;
          _num = 0;
        }
      } else {
        if(_height == 0){
          _height = 150;
          _num = num;
        } else {
          _num = num;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            PayloadDateTimeSelector(
              "Datum", 
              Icons.calendar_month, 
              (label) {
                log(label);
                _toggle(1);
              },
              _num == 1
            ),
            const SizedBox(width: 8,),
            
            PayloadDateTimeSelector(
              "Uhrzeit", 
              Icons.timer, 
              (label) {
                log(label);
                _toggle(2);
              },
              _num == 2
            )
          ],
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOutSine,
          constraints: BoxConstraints(maxHeight: _height),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AnimatedCrossFade(
                  duration:  const Duration(milliseconds: 200),
                  firstChild: Container(
                    height: 150,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime.now(),
                      use24hFormat: true,
                      onDateTimeChanged: (time){
                        _time = DateTime.utc(time.year, time.month, time.day, _time.hour, _time.minute);
                        widget.onTimeChanged(_time);
                      }
                    ),
                  ),
                  secondChild: Container(
                    height: 150,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      minuteInterval: 5,
                      use24hFormat: true,
                      onDateTimeChanged: (time){
                        _time = DateTime.utc(_time.year, _time.month, _time.day, time.hour, time.minute);
                        widget.onTimeChanged(_time);
                      }
                    ),
                  ),
                  crossFadeState: _num == 1 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                ),
              ],
            ),
          ),
        ),
      ],
    );   
  }
}

class PayloadDateTimeSelector extends StatelessWidget{

  final IconData icon;
  final Function(String) onPressed;
  final String label;
  final bool isHighlighted;

  const PayloadDateTimeSelector(this.label, this.icon, this.onPressed, this.isHighlighted, {super.key});

  @override
  Widget build(BuildContext context) {

    var borderTheme = Theme.of(context).inputDecorationTheme;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
    
            image: const DecorationImage(
              image: AssetImage("assets/images/static_noise.jpeg"),
              fit: BoxFit.cover,
              opacity: 0.1
            ),
            
            border: Border.all(
                color: isHighlighted ? CaputColors.colorBlue : borderTheme.border!.borderSide.color,
                width: borderTheme.border!.borderSide.width,
            ),
    
          ),
          child: InkWell(
              splashColor: Colors.grey[600],
              highlightColor: Colors.grey[400],
              onTap: () {
                onPressed(label);
              },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 24.0,
                    color: CaputColors.colorBlue,
                  ),
                  const SizedBox(width: 8,),
                  Text(label, style: const TextStyle(color: CaputColors.colorBlue),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

