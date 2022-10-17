import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Constants {
  static const int splashDelay = 2;
  static Future<String> get downloadPath async {
    var tempDir = await getApplicationDocumentsDirectory();
    return tempDir.path;
  }

  static void showErrorDialog({
    required BuildContext context,
    required String msg,
    VoidCallback? onPress,
  }) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(
                msg,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: onPress ?? () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                      primary: Colors.black,
                      textStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  child: const Text('Ok'),
                )
              ],
            ));
  }

  static void showProgressIndicator(BuildContext context) {
    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Center(
            child: CircularProgressIndicator(
                // valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
          ),
        );
      },
    );
  }
}
