part of '../screens/home_page.dart';

const _locationLabel = 'Distance from Office : ';
const _attendanceInfoLabelTextStyle = TextStyle(
  fontSize: 15.0,
  color: Colors.grey,
  fontWeight: FontWeight.bold,
);
const _attendanceInfoTextStyle = TextStyle(
  fontSize: 18.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);
const _timeTextStyle = TextStyle(
  fontSize: 45.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'Montserrat Light',
);
const _dayAndDateTextStyle = TextStyle(
  fontSize: 17.0,
  color: Colors.grey,
  fontWeight: FontWeight.bold,
);
const _clockInOutLabelTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16.0,
  color: Colors.white,
);
const _clockInButtonColor = Color(0xBB2969B0);
const _clockOutButtonColor = Colors.red;
const _outOfRangeAlertTitle = 'Not in office range!';
const _outOfRangeAlertDescription =
    'You must be in 100m range of branch for check in';
const _clockOutConfirmationDialogTitle = 'Clocking Out!';
const _clockOutConfirmationDescription =
    'Working hours will be calculated based on your last clock out data of the day. Are you sure you want to Clock Out now?';

final TimeAndDate _timeAndDate = TimeAndDate();
final Location locationService = Location();
Map _locationDetails;
String _clockInOutLabelString = clockInLabel.toUpperCase();
Color _clockInOutButtonColor = _clockInButtonColor;

String _time = '';
String _dayAndDate = '';
String distanceDisplay = '';
bool clockedIn = false;
int _distanceFromBranch;

Position _lastKnownPosition;
//StreamSubscription<Position> positionStream;
Timer timerForDateTime;
Timer timerForLocation;
