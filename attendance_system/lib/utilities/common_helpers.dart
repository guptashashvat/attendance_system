import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

void showAlertDialogBox(
    BuildContext context, String dialogBoxTitle, String dialogBoxDescription) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(dialogBoxTitle),
      content: Text(dialogBoxDescription),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, cancelButtonText);
          },
          child: Text(cancelButtonText),
        ),
      ],
    ),
  );
}

void showActionDialogBox(
    BuildContext context,
    String dialogBoxTitle,
    String dialogBoxDescription,
    List<DialogActionButtonsData> actionDetailsList) {
  List<Widget> dialogActions = [];

  actionDetailsList.forEach(
    (DialogActionButtonsData actionButtonData) => dialogActions.add(
      TextButton(
        onPressed: () {
          actionButtonData.action();
        },
        child: Text(actionButtonData.actionText),
      ),
    ),
  );

  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(dialogBoxTitle),
      content: Text(dialogBoxDescription),
      actions: dialogActions,
    ),
  );
}
