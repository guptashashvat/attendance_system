part of '../screens/attendance_history.dart';

class AttendanceDataUtil {
  List<AttendanceInfo> attendanceInfoList = [];
  List<AttendanceInfo> attendanceInfoDisplayList = [];

  void initDummyData(int day, int month, int year, int weekDay) {
    attendanceInfoList = [];
    attendanceInfoDisplayList = [];
    for (int i = day; i > 0; i--) {
      String clockIn, clockOut, workingHours, dayOfWeek;
      if (weekDay == 0) {
        weekDay = 7;
      }
      dayOfWeek = TimeAndDate().getWeekDayString(weekDay);
      if (weekDay == 7) {
        clockIn = kNoDataAvailableDashes;
        clockOut = 'Holiday';
        workingHours = kNoDataAvailableDashes;
      } else {
        var random = new Random();
        int clockInMins = random.nextInt(60);
        int clockOutMins = random.nextInt(60);
        int workingHrsHr = clockOutMins >= clockInMins ? 9 : 8;
        int workingHrsMin = clockOutMins >= clockInMins
            ? clockOutMins - clockInMins
            : 60 - clockInMins + clockOutMins;

        clockIn = '09:${appendZeroToMakeDoubleDigit(clockInMins)}';
        clockOut = '18:${appendZeroToMakeDoubleDigit(clockOutMins)}';
        workingHours =
            '${appendZeroToMakeDoubleDigit(workingHrsHr)}:${appendZeroToMakeDoubleDigit(workingHrsMin)}';
      }
      if (i == _today.day && month == _today.month) {
        clockIn = clockInTimeString;
        clockOut = clockOutTimeString;
        workingHours = workingHrsString;
      }
      attendanceInfoList.add(AttendanceInfo(
          "${appendZeroToMakeDoubleDigit(i)}/${appendZeroToMakeDoubleDigit(month)}/$year",
          dayOfWeek,
          clockIn,
          clockOut,
          workingHours));
      weekDay--;
    }
    attendanceInfoDisplayList = attendanceInfoList;
  }

  void sortColumns(bool isAscending, String sortColumn) {
    String _aSortColumn;
    String _bSortColumn;
    attendanceInfoDisplayList.sort((a, b) {
      int aId = int.tryParse(a.date.substring(0, 2)) ?? 0;
      int bId = int.tryParse(b.date.substring(0, 2)) ?? 0;
      if (sortColumn == clockInLabel) {
        _aSortColumn = a.clockInTime;
        _bSortColumn = b.clockInTime;
      } else if (sortColumn == clockOutLabel) {
        _aSortColumn = a.clockOutTime;
        _bSortColumn = b.clockOutTime;
      } else if (sortColumn == workingHrsLabel) {
        _aSortColumn = a.workingHours;
        _bSortColumn = b.workingHours;
      } else {
        return (aId - bId) * (isAscending ? 1 : -1);
      }

      if (_aSortColumn != _bSortColumn) {
        aId = int.tryParse(_aSortColumn.substring(0, 2)) ?? 0;
        bId = int.tryParse(_bSortColumn.substring(0, 2)) ?? 0;
        if (aId == bId) {
          aId = int.tryParse(_aSortColumn.substring(3, 5)) ?? 0;
          bId = int.tryParse(_bSortColumn.substring(3, 5)) ?? 0;
        }
      }
      return (aId - bId) * (isAscending ? 1 : -1);
    });
    //_generateLeftSideChildrenList();
    //_generateRightSideChildrenList();
  }

  void updateAttedanceInfoDisplayList(int day, int month, int year) {
    attendanceInfoDisplayList = [];
    String date =
        "${appendZeroToMakeDoubleDigit(day)}/${appendZeroToMakeDoubleDigit(month)}/$year";
    for (int i = 0; i < attendanceInfoList.length; i++) {
      if (attendanceInfoList[i].date == date) {
        attendanceInfoDisplayList.add(attendanceInfoList[i]);
        return;
      }
    }
    attendanceInfoDisplayList = attendanceInfoList;
  }
}

class AttendanceInfo {
  String date;
  String dayOfWeek;
  String clockInTime;
  String clockOutTime;
  String workingHours;

  AttendanceInfo(this.date, this.dayOfWeek, this.clockInTime, this.clockOutTime,
      this.workingHours);
}

AttendanceDataUtil attendanceDataUtil = AttendanceDataUtil();

int _calendarFlex = 2;
int _dataTableFlex = 3;

// For HorizontalDataTable

HDTRefreshController _hdtRefreshController = HDTRefreshController();

bool isAscending = true;

String sortType = '';

Widget _getTitleItemWidget(String label, double width) {
  return Container(
    child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
    width: width,
    height: 56,
    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
    alignment: Alignment.center,
  );
}

Widget _generateFirstColumnRow(BuildContext context, int index) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          attendanceDataUtil.attendanceInfoDisplayList[index].date,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          attendanceDataUtil.attendanceInfoDisplayList[index].dayOfWeek,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color:
                attendanceDataUtil.attendanceInfoDisplayList[index].dayOfWeek ==
                        'Sunday'
                    ? Colors.red
                    : Colors.black,
          ),
        ),
      ],
    ),
    width: _tableCellWidth,
    height: _tableCellHeight,
    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
    alignment: Alignment.center,
  );
}

Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
  return Row(
    children: <Widget>[
      Container(
        child: Text(
            attendanceDataUtil.attendanceInfoDisplayList[index].clockInTime),
        width: _tableCellWidth,
        height: _tableCellHeight,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      ),
      Container(
        child: Text(
          attendanceDataUtil.attendanceInfoDisplayList[index].clockOutTime,
          style: TextStyle(
            //fontWeight: FontWeight.bold,
            color:
                attendanceDataUtil.attendanceInfoDisplayList[index].dayOfWeek ==
                        'Sunday'
                    ? Colors.red
                    : Colors.black,
          ),
        ),
        width: _tableCellWidth,
        height: _tableCellHeight,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      ),
      Container(
        child: Text(
            attendanceDataUtil.attendanceInfoDisplayList[index].workingHours,
            style: TextStyle(
              color: attendanceDataUtil
                          .attendanceInfoDisplayList[index].dayOfWeek ==
                      'Sunday'
                  ? Colors.black
                  : Colors.green,
            )),
        width: _tableCellWidth,
        height: _tableCellHeight,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      ),
    ],
  );
}

const double _tableCellHeight = 60;
const double _tableCellWidth = 100;

// Table Calender related references

final _today = DateTime.now();
final _firstDayInCalendar =
    DateTime(_today.year, _today.month - 11, _today.day);
final _lastDayInCalendar = DateTime(_today.year, _today.month, _today.day);
CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
DateTime _focusedDay = DateTime.now();
DateTime _selectedDay;
