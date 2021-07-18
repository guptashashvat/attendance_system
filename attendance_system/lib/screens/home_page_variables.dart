part of '../screens/home_page.dart';

final TimeAndDate _timeAndDate = TimeAndDate();
final Location locationService = Location();
Map _locationDetails;
String _clockInOutLabelString = _clockInLabel.toUpperCase();
Color _clockInOutButtonColor = _clockInButtonColor;

String _checkInTimeString = '--';
String _checkOutTimeString = '--';
String _workingHrsString = '--';
String _time = '';
String _dayAndDate = '';
bool clockedIn = false;

Position _lastKnownPosition;
StreamSubscription<Position> positionStream;
Timer timer;
