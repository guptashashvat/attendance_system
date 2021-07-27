import 'package:flutter/cupertino.dart';
import '../utilities/common_helpers.dart';

class TimeAndDate {
  String getTime({String format = "24"}) {
    int hour = DateTime.now().hour;
    int minute = DateTime.now().minute;
    String _time =
        '${appendZeroToMakeDoubleDigit(hour)}:${appendZeroToMakeDoubleDigit(minute)}';

    if (format == "12") {
      String am_pm = hour >= 12 ? 'PM' : 'AM';
      hour = (hour > 12) ? (hour - 12) : hour;
      _time =
          '${appendZeroToMakeDoubleDigit(hour)}:${appendZeroToMakeDoubleDigit(minute)} $am_pm';
    }

    return _time;
  }

  String getCurrentTimeDiffFromEarlierTime(
      {@required String earlierTimeString}) {
    int currentHour = DateTime.now().hour;
    int currentMinute = DateTime.now().minute;
    int earlierHour = int.parse(earlierTimeString.substring(0, 2));
    int earlierMinute = int.parse(earlierTimeString.substring(3, 5));
    var formatIdentifier =
        earlierTimeString.substring(earlierTimeString.length - 2);
    int hourDiff = currentHour - earlierHour;
    int minuteDiff = currentMinute - earlierMinute;
    if (formatIdentifier == 'PM') {
      hourDiff = (earlierHour == 12)
          ? currentHour - earlierHour
          : currentHour - (12 + earlierHour);
    }
    if (minuteDiff < 0) {
      hourDiff = hourDiff - 1;
      minuteDiff = 60 - earlierMinute + currentMinute;
    }
    return '${appendZeroToMakeDoubleDigit(hourDiff)}:${appendZeroToMakeDoubleDigit(minuteDiff)}';
  }

  String getDayAndDate() {
    return '${getWeekDayString(DateTime.now().weekday)}, ${getMonthString(DateTime.now().month).substring(0, 3)} ${DateTime.now().day}';
  }

  String getWeekDayString(int weekDay) {
    switch (weekDay) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return 'Sunday';
    }
  }

  String getMonthString(int month) {
    switch (month) {
      case DateTime.january:
        return 'January';
      case DateTime.february:
        return 'February';
      case DateTime.march:
        return 'March';
      case DateTime.april:
        return 'April';
      case DateTime.may:
        return 'May';
      case DateTime.june:
        return 'June';
      case DateTime.july:
        return 'July';
      case DateTime.august:
        return 'August';
      case DateTime.september:
        return 'September';
      case DateTime.october:
        return 'October';
      case DateTime.november:
        return 'November';
      case DateTime.december:
        return 'December';
      default:
        return 'January';
    }
  }
}
