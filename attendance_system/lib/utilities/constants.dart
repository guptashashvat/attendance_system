import 'package:flutter/material.dart';

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

const branchLatitude = 27.9343;
const branchLongitude = 80.7882;
const maximumAcceptableDistanceFromBranch = 100;
const cancelButtonText = 'Cancel';

class DialogActionButtonsData {
  final String actionText;
  final Function action;

  const DialogActionButtonsData(
      {@required this.actionText, @required this.action});
}
