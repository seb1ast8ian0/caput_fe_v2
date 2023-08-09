import 'dart:developer';

import 'package:Caput/domain/bloc/input_blocs/neuron_input/neuron_input_bloc.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:Caput/presentation/widgets/util/input/buttons/caput_secondary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayloadInput extends StatefulWidget {
  final AnimationController animationController;
  final ScrollController scrollController;

  /*

  widget.scrollController.animateTo(0, duration: Duration(milliseconds: 200), curve: Curves.bounceInOut);

  */

  const PayloadInput(
      {Key? key,
      required this.animationController,
      required this.scrollController})
      : super(key: key);

  @override
  PayloadInputState createState() => PayloadInputState();
}

class PayloadInputState extends State<PayloadInput>
    with TickerProviderStateMixin {
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  Widget payloadBody = Container();

  double _height = 0;
  int _col = 0;
  bool inputIsHidden = true;

  @override
  void initState() {

    super.initState();

    Tween<Offset> offsetTween =
        Tween<Offset>(begin: const Offset(0.0, 0.6), end: Offset.zero);
    _offsetAnimation = offsetTween.animate(CurvedAnimation(
        parent: widget.animationController, curve: Curves.easeInOutSine));

    _opacityAnimation = CurvedAnimation(
        parent: widget.animationController, curve: Curves.elasticInOut);

    widget.animationController.addListener(() {

      var status = widget.animationController.status;
      setState(() {
        inputIsHidden = hideInputFromControllerStatus(status);
      });

    });
  }

  bool hideInputFromControllerStatus(AnimationStatus status) {
    if (status == AnimationStatus.forward ||
        status == AnimationStatus.completed) {
      return false;
    }

    if (status == AnimationStatus.reverse ||
        status == AnimationStatus.dismissed) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {

    NeuronInputBloc neuronInputBloc = context.read<NeuronInputBloc>();

    return BlocListener<NeuronInputBloc, NeuronInputState>(
      listener: (context, state) {
        if (state is NeuronInputClean) {
          setState(() {
            _col = 0;
            _height = 0;
          });
        }
      },
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: SlideTransition(
          position: _offsetAnimation,
          child: IgnorePointer(
            ignoring: inputIsHidden,
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.elliptical(8, 8)),
                  color: Theme.of(context)
                      .appBarTheme
                      .backgroundColor
                      //!.withOpacity(0.5)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CaputSecondaryButton(
                            isSelected: _col == 1,
                            buttonKey: "task",
                            icon: Icons.check,
                            onPressed: () {
                              neuronInputBloc.add(
                                const NeuronInputSetTypeEvent("task")
                              );
                              toggle(1);
                              setState(() {
                                payloadBody = buildTaskInput();
                              });
                            },
                            highlightColor: CaputColors.colorBlue,
                          ),
                          const SizedBox(width: 8),
                          CaputSecondaryButton(
                            isSelected: _col == 2,
                            buttonKey: "date",
                            icon: Icons.calendar_today_rounded,
                            onPressed: () {
                              log("date");
                              neuronInputBloc.add(
                                const NeuronInputSetTypeEvent("date")
                              );
                              toggle(2);
                              setState(() {
                                payloadBody = buildDateInput();
                              });
                            },
                            highlightColor: CaputColors.colorBlue,
                          ),
                        ],
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
                        child: SingleChildScrollView(child: payloadBody),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void toggle(int column) {

    NeuronInputBloc neuronInputBloc = context.read<NeuronInputBloc>();

    double newHeight = 0;
    int newColumn = 0;

    if (_col == 0) {

      newHeight = 300;
      newColumn = column;

    } else {

      if (_col == column) {
        neuronInputBloc.add(const NeuronInputSetTypeEvent("note"));

        if (_height == 0) {
          newHeight = 300;
        } else {
          newHeight = 0;
          newColumn = 0;
        }

      } else {
        newHeight = 300;
        newColumn = column;
      }

    }

    log("height before: $_height");
    log("col before: $_col");

    setState(() {
      _height = newHeight;
      _col = newColumn;
    });

    log("height after: $_height");
    log("col after: $_col");

  }

  Widget buildTaskInput() {
    NeuronInputBloc neuronInputBloc = context.read<NeuronInputBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        PayloadDateTimeInput(
          onTimeChanged: (time) {
            log(time.toString());
            neuronInputBloc.add(NeuronInputSetDateEvent(time));
          },
        ),
        const SizedBox(height: 4)
      ],
    );
  }

  Widget buildDateInput() {
    NeuronInputBloc neuronInputBloc = context.read<NeuronInputBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        PayloadDateTimeInput(
          onTimeChanged: (time) {
            log(time.toString());
            neuronInputBloc.add(NeuronInputSetDateEvent(time));
          },
        ),
        const SizedBox(height: 4)
      ],
    );
  }

}

class PayloadInputButton extends StatelessWidget {

  final IconData icon;
  final Function()? onPressed;
  final bool isHighlighted;

  const PayloadInputButton(this.isHighlighted, this.icon, this.onPressed,
      {super.key});

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
              opacity: 0.1),
          border: Border.all(
            color: isHighlighted
                ? CaputColors.colorBlue
                : borderTheme.border!.borderSide.color,
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

enum Toggle { none, date, time }

class PayloadDateTimeInput extends StatefulWidget {
  final Function(DateTime?) onTimeChanged;

  const PayloadDateTimeInput({required this.onTimeChanged, Key? key})
      : super(key: key);

  @override
  _PayloadDateTimeInputState createState() => _PayloadDateTimeInputState();
}

class _PayloadDateTimeInputState extends State<PayloadDateTimeInput> {
  final List<Toggle> _toggles = [];
  double _height = 0;

  DateTime? _time;
  DateTime? _previousTime;

  toggle(Toggle toggle) {
    //Bestimmung des zuletzt angewählten Elementes
    Toggle last = _toggles.isEmpty ? Toggle.none : _toggles.last;

    setState(() {
      if (_toggles.contains(toggle)) {
        //wenn item schon ausgewählt ist
        if (_height == 0) {
          //exande, falls noch nicht
          _height = 150;
        } else {
          if (toggle == last) {
            //wenn aktueller Toggle letzter ist (doppel Tap), dann entferne ihn und setze Datum zurück
            _toggles.remove(toggle);
            if (toggle == Toggle.date) {
              updateDate(DateTime.now());
            } else if (toggle == Toggle.time) {
              DateTime currentDate = DateTime.now()
                  .add(Duration(minutes: 5 - (DateTime.now().minute % 5)));
              updateTime(currentDate);
            }
          } else {
            //wenn nicht letzter, setze ihn auf letzten
            _toggles.remove(toggle);
            _toggles.add(toggle);
          }

          if (_toggles.isEmpty) {
            //wenn nichts ausgewählt: setze Zeit auf null
            _time = null;
            widget.onTimeChanged(_time);
            _height = 0;
          }
        }
      } else {
        //wenn item noch nicht ausgewählt
        if (_height == 0) {
          //expande, falls noch nicht
          _height = 150;
        }

        //wähle aus
        _toggles.add(toggle);
        if (toggle == Toggle.date) {
          DateTime currentDate = DateTime.now();
          DateTime dateWithZeroTime = DateTime(
              currentDate.year, currentDate.month, currentDate.day, 0, 0, 0, 0);
          //updateDate(dateWithZeroTime);
          updateTime(dateWithZeroTime);
        } else if (toggle == Toggle.time) {
          DateTime currentDate = DateTime.now()
              .add(Duration(minutes: 5 - (DateTime.now().minute % 5)));
          updateTime(currentDate);
        }
      }
    });
  }

  updateTime(DateTime time) {
    log("update time");
    _time ??= DateTime.now();
    _time = DateTime.utc(
        _time!.year, _time!.month, _time!.day, time.hour, time.minute);

    if (_time != _previousTime) {
      _previousTime = _time; // Aktualisiere das vorherige Datum
      widget.onTimeChanged(_time!);
    }
  }

  updateDate(DateTime date) {
    log("update date");
    _time ??= DateTime.now();
    _time = DateTime.utc(
        date.year, date.month, date.day, _time!.hour, _time!.minute);
    widget.onTimeChanged(_time!);

    if (_time != _previousTime) {
      // Überprüfe, ob sich das Datum geändert hat
      _previousTime = _time; // Aktualisiere das vorherige Datum
      widget.onTimeChanged(_time!);
    }
  }

  @override
  Widget build(BuildContext context) {
    int showNum = 0;
    if (_toggles.isNotEmpty) {
      showNum = _toggles.last == Toggle.date ? 1 : 0;
    }

    DateTime initialDateTime =
        DateTime.now().add(Duration(minutes: 5 - (DateTime.now().minute % 5)));

    return BlocListener<NeuronInputBloc, NeuronInputState>(
      listener: (context, state) {
        if (state is NeuronInputClean) {
          setState(() {
            _toggles.removeRange(0, _toggles.length);
            _height = 0;
          });
        }
      },
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CaputSecondaryButton(
                  isSelected: _toggles.contains(Toggle.date),
                  buttonKey: "date",
                  label: "Datum",
                  icon: Icons.calendar_month,
                  onPressed: () {
                    toggle(Toggle.date);
                  },
                  highlightColor: CaputColors.colorBlue),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CaputSecondaryButton(
                  isSelected: _toggles.contains(Toggle.time),
                  buttonKey: "time",
                  label: "Uhrzeit",
                  icon: Icons.timer,
                  onPressed: () {
                    toggle(Toggle.time);
                  },
                  highlightColor: CaputColors.colorBlue),
              ),
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
                    duration: const Duration(milliseconds: 200),
                    firstChild: SizedBox(
                      height: 150,
                      child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: DateTime.now(),
                          use24hFormat: true,
                          onDateTimeChanged: (time) {
                            updateDate(time);
                          }),
                    ),
                    secondChild: SizedBox(
                      height: 150,
                      child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          minuteInterval: 5,
                          initialDateTime: initialDateTime,
                          use24hFormat: true,
                          onDateTimeChanged: (time) {
                            updateTime(time);
                          }),
                    ),
                    crossFadeState: showNum == 1
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
