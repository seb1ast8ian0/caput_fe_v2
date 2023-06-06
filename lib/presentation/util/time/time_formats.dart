
class TimeFormats{

  static String getNeuronDate(DateTime time){

    DateTime now = DateTime.now();

    //Duration difference = time.difference(now);

    if(now.day == time.day && now.month == time.month && now.year == time.year){
      //time ist heute
      return getTimeFromDateAsString(time);
    } else {
      //time ist an einem anderen Datum
      return "${time.day}.${time.month}.${time.year}";
    }
  }


  static String getTimeFromDateAsString(DateTime time){

    String minuteString;
    String hourString;
    int minute = time.minute;
    int hour = time.hour;

    if (minute > 9){
      minuteString = minute.toString();
    } else {
      minuteString = "0$minute";
    }

    if (hour > 9){
      hourString = hour.toString();
    } else {
      hourString = "0$hour";
    }
    
    return "$hourString:$minuteString";

  }


}