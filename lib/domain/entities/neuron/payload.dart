abstract class Payload{

  late String type;
  late String caption;
  late int priority;

  Payload({ required this.type, required this.caption, required this.priority});

  Payload.empty() : super();

  @override
  String toString() {
    return 'type: [$type] caption: [$caption]';
  }

}