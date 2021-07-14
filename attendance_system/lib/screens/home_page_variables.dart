part of '../screens/home_page.dart';

final TimeAndDate _timeAndDate = TimeAndDate();

String _location = '';
String _clockInOutLabelString = _clockInLabel.toUpperCase();
Color _clockInOutButtonColor = _clockInButtonColor;

String _checkInTimeString = '--';
String _checkOutTimeString = '--';
String _workingHrsString = '--';
String _time = '';
String _dayAndDate = '';

Position prevPosition;
StreamSubscription<Position> positionStream;
