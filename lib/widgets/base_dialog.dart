import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget {
  const BaseDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.confirmColor = Colors.blue,
    this.closeColor = Colors.red,
    this.confirmText = 'Yes, Confirm',
    this.closeText = 'No, Close',
    required this.child,
  });

  final Function onConfirm;
  final String title;
  final Color confirmColor;
  final Color closeColor;
  final String confirmText;
  final String closeText;
  final Widget content;
  final Widget child;

  alertTitle(BuildContext context) {
    return Text(title);
  }

  alertContent(BuildContext context) {
    return content;
  }

  alertActions(BuildContext context) {
    return [
      TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            closeText,
            style: TextStyle(color: closeColor),
          )),
      TextButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: Text(
            confirmText,
            style: TextStyle(color: confirmColor),
          )),
    ];
  }

  void displayDialogIOS(BuildContext context) {
    showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: alertTitle(context),
            content: alertContent(context),
            actions: alertActions(context),
          );
        });
  }

  void displayDialogAndroid(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (contenxt) {
          return AlertDialog(
            elevation: 5,
            title: alertTitle(context),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(18)),
            content: alertContent(context),
            actions: alertActions(context),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Platform.isAndroid
          ? displayDialogAndroid(context)
          : displayDialogIOS(context),
      child: child,
    );
  }
}
