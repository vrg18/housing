import 'package:flutter/material.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SizedBox(
            width: widthWebWrapper / 2,
            child: Image.asset(
              logoPicture,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
