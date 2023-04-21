import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tichu_flutter/main.dart';
import 'package:velocity_x/velocity_x.dart';

void showPlatformAlertDialog({
  required String title,
  String? contentText,
  Widget? contentWidget,
  String button1Text = 'OK',
  void Function()? button1OnPressed,
  String? button2Text,
  void Function()? button2OnPressed,
}) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => (Platform.isAndroid)
        ? AlertDialog(
            title: Text(
              title,
              style: context.textTheme.titleLarge,
            ),
            content: contentWidget ??
                (contentText != null ? Text(contentText) : null),
            actions: [
              TextButton(
                onPressed:
                    button1OnPressed ?? () => Navigator.of(context).pop(),
                child: Text(button1Text),
              ),
              if (button2Text != null && button2OnPressed != null)
                TextButton(
                  onPressed: button2OnPressed,
                  child: Text(button2Text),
                ),
            ],
          )
        : CupertinoAlertDialog(
            title: Text(
              title,
              style: context.textTheme.titleLarge,
            ),
            content: contentWidget ??
                (contentText != null ? Text(contentText) : null),
            actions: [
              TextButton(
                onPressed:
                    button1OnPressed ?? () => Navigator.of(context).pop(),
                child: Text(button1Text),
              ),
              if (button2Text != null && button2OnPressed != null)
                TextButton(
                  onPressed: button2OnPressed,
                  child: Text(button2Text),
                ),
            ],
          ),
  );
}
