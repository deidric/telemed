import 'package:flutter/material.dart';
import 'package:telemed/UI/SignInSignUp/signInPage.dart';
import 'package:telemed/settings.dart';

class DialogUtils {
  static Future<bool?> displayDialogOKCancelCallBack(
      {required BuildContext context,
      required String title,
      required String message}) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                TelemedImage.logoImage,
                width: 24,
                height: 24,
              ),
            ),
            Text(title.toUpperCase()),
          ]),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(TelemedStrings.cancel.toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(TelemedStrings.ok.toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<bool?> displayDialogOKCallBack(
      BuildContext context, String title, String message) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                TelemedImage.logoImage,
                width: 24,
                height: 24,
              ),
            ),
            Text(title),
          ]),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(TelemedStrings.ok.toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<bool?> displayDialogOKforAppointScheduledCallBack(
      BuildContext context, String title, String message) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                TelemedImage.logoImage,
                width: 24,
                height: 24,
              ),
            ),
            Text(title),
          ]),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(TelemedStrings.ok.toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<bool?> displayDialogOKCallBackAuthDialog(
      BuildContext context, String title, String message) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                TelemedImage.logoImage,
                width: 24,
                height: 24,
              ),
            ),
            Text(title),
          ]),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(TelemedStrings.ok.toUpperCase()),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, SignInPage.route, (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
