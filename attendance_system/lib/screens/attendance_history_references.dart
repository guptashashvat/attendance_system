part of '../screens/attendance_history.dart';

class DummyAttendanceData {
  List<AttendanceInfo> attendanceInfo = [];

  void initData(int size) {
    for (int i = 0; i < size; i++) {
      attendanceInfo.add(AttendanceInfo(
          "${i < 10 ? '0${i + 1}' : i + 1}/07/2021", '09:00', '18:00', '9:00'));
    }
  }

  void sortColumns(bool isAscending, String sortColumn) {
    String _aSortColumn;
    String _bSortColumn;
    attendanceInfo.sort((a, b) {
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
  }
}

class AttendanceInfo {
  String date;
  String clockInTime;
  String clockOutTime;
  String workingHours;

  AttendanceInfo(
      this.date, this.clockInTime, this.clockOutTime, this.workingHours);
}

DummyAttendanceData dummyAttendanceData = DummyAttendanceData();

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
    child: Text(dummyAttendanceData.attendanceInfo[index].date),
    width: 100,
    height: 52,
    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
    alignment: Alignment.center,
  );
}

Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
  return Row(
    children: <Widget>[
      Container(
        child: Text(dummyAttendanceData.attendanceInfo[index].clockInTime),
        width: 100,
        height: 52,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      ),
      Container(
        child: Text(dummyAttendanceData.attendanceInfo[index].clockOutTime),
        width: 100,
        height: 52,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      ),
      Container(
        child: Text(dummyAttendanceData.attendanceInfo[index].workingHours),
        width: 100,
        height: 52,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      ),
    ],
  );
}

// Table Calender related references

final _today = DateTime.now();
final _firstDayInCalendar =
    DateTime(_today.year, _today.month - 11, _today.day);
final _lastDayInCalendar = DateTime(_today.year, _today.month, _today.day);
CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
DateTime _focusedDay = DateTime.now();
DateTime _selectedDay;
