part of '../screens/attendance_history.dart';

class AttendanceDataUtil {
  List<AttendanceInfo> attendanceInfoList = [];
  List<AttendanceInfo> attendanceInfoDisplayList = [];

  void initDummyData(int size) {
    for (int i = 0; i < size; i++) {
      var random = new Random();
      int clockInMins = random.nextInt(60);
      int clockOutMins = random.nextInt(60);
      int workingHrsHr = clockOutMins >= clockInMins ? 9 : 8;
      int workingHrsMin = clockOutMins >= clockInMins
          ? clockOutMins - clockInMins
          : 60 - clockInMins + clockOutMins;
      attendanceInfoList.add(AttendanceInfo(
          "${i < 9 ? '0${i + 1}' : i + 1}/07/2021",
          '09:${clockInMins < 10 ? '0$clockInMins' : clockInMins}',
          '18:${clockOutMins < 10 ? '0$clockOutMins' : clockOutMins}',
          '${workingHrsHr < 10 ? '0$workingHrsHr' : workingHrsHr}:${workingHrsMin < 10 ? '0$workingHrsMin' : workingHrsMin}'));
    }
    attendanceInfoDisplayList = attendanceInfoList;
  }

  void sortColumns(bool isAscending, String sortColumn) {
    String _aSortColumn;
    String _bSortColumn;
    attendanceInfoList.sort((a, b) {
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
    child: Text(attendanceDataUtil.attendanceInfoList[index].date),
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
        child: Text(attendanceDataUtil.attendanceInfoList[index].clockInTime),
        width: 100,
        height: 52,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      ),
      Container(
        child: Text(attendanceDataUtil.attendanceInfoList[index].clockOutTime),
        width: 100,
        height: 52,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      ),
      Container(
        child: Text(attendanceDataUtil.attendanceInfoList[index].workingHours),
        width: 100,
        height: 52,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      ),
    ],
  );
}

List<Widget> _generateLeftSideChildrenList() {
  for (int i = 0;
      i < attendanceDataUtil.attendanceInfoDisplayList.length;
      i++) {
    _leftHandSideChildren.add(Container(
      child: Text(attendanceDataUtil.attendanceInfoDisplayList[i].date),
      width: 100,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
    ));
  }
  return _leftHandSideChildren;
}

List<Widget> _generateRightSideChildrenList() {
  for (int index = 0;
      index < attendanceDataUtil.attendanceInfoDisplayList.length;
      index++) {
    _rightHandSideChildren.add(Row(
      children: <Widget>[
        Container(
          child: Text(
              attendanceDataUtil.attendanceInfoDisplayList[index].clockInTime),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text(
              attendanceDataUtil.attendanceInfoDisplayList[index].clockOutTime),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text(
              attendanceDataUtil.attendanceInfoDisplayList[index].workingHours),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
      ],
    ));
  }
  return _rightHandSideChildren;
}

List<Widget> _leftHandSideChildren = [];
List<Widget> _rightHandSideChildren = [];

// Table Calender related references

final _today = DateTime.now();
final _firstDayInCalendar =
    DateTime(_today.year, _today.month - 11, _today.day);
final _lastDayInCalendar = DateTime(_today.year, _today.month, _today.day);
CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
DateTime _focusedDay = DateTime.now();
DateTime _selectedDay;
