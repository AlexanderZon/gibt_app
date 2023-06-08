import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteIconButtonDialog extends StatelessWidget {
  const DeleteIconButtonDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.onConfirm});

  final String content;
  final Function onConfirm;
  final String title;

  alertTitle(BuildContext context) {
    return Text(title);
  }

  alertContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(content),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  alertActions(BuildContext context) {
    return [
      TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'No, Cancel',
            style: TextStyle(color: Colors.red),
          )),
      TextButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: const Text('Yes, Delete')),
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
    return IconButton(
        onPressed: () => Platform.isAndroid
            ? displayDialogAndroid(context)
            : displayDialogIOS(context),
        icon: const Icon(Icons.delete));
  }
}
