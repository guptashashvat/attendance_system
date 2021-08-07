import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

const kSignInEndpoint = 'https://example.com/signin';
const kThemeColor = Color(0xFF2969B0);

const kLabelTextStyle = TextStyle(
  fontSize: 18.0,
  color: Colors.white,
);

const kLargeButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);
const kBottomContainerHeight = 80.0;
const kBottomContainerColor = Color(0xFFEB1555);
const kNoDataAvailableDashes = '--';
const kDownArrow = '↓';
const kUpArrow = '↑';
const kDataTableHeaderTextStyle = TextStyle(
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.bold,
);
const branchLatitude = 30.48186440439275;
const branchLongitude = 78.0334855053766;
const maximumAcceptableDistanceFromBranch = 100;
const cancelButtonText = 'Cancel';
const clockInLabel = 'Clock In';
const clockOutLabel = 'Clock Out';
const workingHrsLabel = "Working Hr's";
const dateLabel = "Date";

String clockInTimeString = kNoDataAvailableDashes;
String clockOutTimeString = kNoDataAvailableDashes;
String workingHrsString = kNoDataAvailableDashes;

class DialogActionButtonsData {
  final String actionText;
  final Function action;

  const DialogActionButtonsData(
      {@required this.actionText, @required this.action});
}
