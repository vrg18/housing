import 'package:flutter/material.dart';
import 'package:housing/ui/res/strings.dart';

Future popupMessage(BuildContext context, String content) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      print(content);
      return AlertDialog(
        title: Text(popupHeader),
        content: Text(content),
        actions: [
          SizedBox(
            width: 48,
            child: TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      );
    },
  );
}
