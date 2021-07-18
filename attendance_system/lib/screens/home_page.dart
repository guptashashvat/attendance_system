import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attendance_system/components/round_icon_button.dart';
import 'package:attendance_system/components/icon_content.dart';
import 'package:attendance_system/utilities/constants.dart';
import 'package:line_icons/line_icons.dart';
import 'package:attendance_system/services/day_date_time.dart';
import 'package:geolocator/geolocator.dart';
import 'package:attendance_system/services/location.dart';

part '../utilities/home_page_constants.dart';
part '../screens/home_page_variables.dart';

class HomePage extends StatefulWidget {
  HomePage({this.location});
  final location;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _location = widget.location ?? "";
    _time = _timeAndDate.getTime();
    _dayAndDate = _timeAndDate.getDayAndDate();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _time = _timeAndDate.getTime();
        _dayAndDate = _timeAndDate.getDayAndDate();
      });
    });

    positionStream = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.lowest,
    ).listen((Position position) async {
      if (lastKnownPosition == null ||
          lastKnownPosition.longitude != position.longitude ||
          lastKnownPosition.latitude != position.latitude) {
        String tempLocation =
            await locationService.getCurrentLocation(position: position);
        setState(() {
          lastKnownPosition = position;
          _location = tempLocation;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    _time,
                    style: _timeTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text(
                    _dayAndDate,
                    style: _dayAndDateTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: RoundIconButton(
                  elevation: 12.0,
                  color: _clockInOutButtonColor,
                  width: 150.0,
                  height: 150.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 42.0),
                    child: IconContent(
                      icon: CupertinoIcons.hand_draw,
                      label: _clockInOutLabelString,
                      labelTextStyle: _clockInOutLabelTextStyle,
                      iconSize: 65.0,
                      iconColor: Colors.white,
                      sizedBoxHeight: 0.0,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (!clockedIn) {
                        if (locationService.getDistanceFromBranchLocation(
                                position: lastKnownPosition) >
                            maximumAcceptableDistanceFromBranch) {
                        } else {
                          _clockInOutLabelString = _clockOutLabel.toUpperCase();
                          _clockInOutButtonColor = _clockOutButtonColor;
                          _checkInTimeString = _time;
                          clockedIn = true;
                        }
                      } else {
                        _checkOutTimeString = _time;
                        _workingHrsString =
                            _timeAndDate.getCurrentTimeDiffFromEarlierTime(
                                earlierTimeString: _checkInTimeString);
                      }
                    });
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 20.0,
                    ),
                    Flexible(
                      child: Text(
                        _locationLabel + _location,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconContent(
                        icon: Icons.more_time_rounded,
                        iconSize: 40.0,
                        iconColor: Colors.black54,
                        label: _checkInTimeString,
                        labelTextStyle: _attendanceInfoTextStyle,
                        label2: _clockInLabel,
                        label2TextStyle: _attendanceInfoLabelTextStyle,
                        sizedBox2Height: 0.0,
                        sizedBoxHeight: 0.0,
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      IconContent(
                        icon: CupertinoIcons.timer,
                        iconSize: 40.0,
                        iconColor: Colors.black54,
                        label: _checkOutTimeString,
                        labelTextStyle: _attendanceInfoTextStyle,
                        label2: _clockOutLabel,
                        label2TextStyle: _attendanceInfoLabelTextStyle,
                        sizedBox2Height: 0.0,
                        sizedBoxHeight: 0.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      IconContent(
                        icon: LineIcons.clockAlt,
                        iconSize: 40.0,
                        iconColor: Colors.black54,
                        label: _workingHrsString,
                        labelTextStyle: _attendanceInfoTextStyle,
                        label2: _workingHrsLabel,
                        label2TextStyle: _attendanceInfoLabelTextStyle,
                        sizedBox2Height: 0.0,
                        sizedBoxHeight: 0.0,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    positionStream.cancel();
    timer.cancel();
  }
}
