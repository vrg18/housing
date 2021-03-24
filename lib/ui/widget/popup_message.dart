import 'package:flutter/material.dart';
import 'package:housing/ui/res/strings.dart';

Future popupMessage(BuildContext context, String content) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(popupHeader),
      content: Text(content),
      actions: [
        SizedBox(
          width: 64,
          child: ElevatedButton(
            child: Text('Ok'),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    ),
  );
}
