import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import '../utilities/constants.dart';
import 'package:intl/intl.dart';
import '../utilities/common_helpers.dart';
import 'package:table_calendar/table_calendar.dart';

part '../screens/attendance_history_references.dart';

class AttendanceHistory extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _AttendanceHistoryState createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory> {
  @override
  void initState() {
    dummyAttendanceData.initData(30);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: _calendarFlex,
              child: TableCalendar(
                firstDay: _firstDayInCalendar,
                lastDay: _lastDayInCalendar,
                focusedDay: _focusedDay,
                rowHeight: 53.0,
                calendarFormat: _calendarFormat,
                availableCalendarFormats: const {
                  CalendarFormat.twoWeeks: '2 Weeks',
                  CalendarFormat.week: 'Week'
                },
                calendarBuilders: CalendarBuilders(
                  dowBuilder: (context, day) {
                    if (day.weekday == DateTime.sunday) {
                      final text = DateFormat.E().format(day);

                      return Center(
                        child: Text(
                          text,
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return null;
                  },
                ),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                      if (format == CalendarFormat.twoWeeks) {
                        _calendarFlex = 2;
                        _dataTableFlex = 3;
                      } else {
                        Future.delayed(const Duration(milliseconds: 150), () {
                          setState(() {
                            _calendarFlex = 2;
                            _dataTableFlex = 5;
                          });
                        });
                      }
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ),
            Flexible(
              flex: _dataTableFlex,
              child: HorizontalDataTable(
                leftHandSideColumnWidth: 100,
                rightHandSideColumnWidth: 300,
                isFixedHeader: true,
                headerWidgets: _getTitleWidget(),
                leftSideItemBuilder: _generateFirstColumnRow,
                rightSideItemBuilder: _generateRightHandSideColumnRow,
                itemCount: dummyAttendanceData.attendanceInfo.length,
                rowSeparatorWidget: const Divider(
                  color: Colors.black54,
                  height: 1.0,
                  thickness: 0.0,
                ),
                leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
                rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
                enablePullToRefresh: true,
                refreshIndicator: const WaterDropHeader(),
                refreshIndicatorHeight: 30,
                onRefresh: () async {
                  //Do sth
                  await Future.delayed(const Duration(milliseconds: 500));
                  _hdtRefreshController.refreshCompleted();
                },
                htdRefreshController: _hdtRefreshController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _tableHeaderCell(dateLabel),
      _tableHeaderCell(clockInLabel),
      _tableHeaderCell(clockOutLabel),
      _tableHeaderCell(workingHrsLabel),
    ];
  }

  TextButton _tableHeaderCell(String label) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: _getTitleItemWidget(
          label +
              (sortType == label ? (isAscending ? kDownArrow : kUpArrow) : ''),
          100),
      onPressed: () {
        sortType = label;
        isAscending = !isAscending;
        dummyAttendanceData.sortColumns(isAscending, label);
        setState(() {});
      },
    );
  }
}
