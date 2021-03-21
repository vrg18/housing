import 'package:flutter/material.dart';
import 'package:housing/ui/res/sizes.dart';

class LoginProgressIndicator extends StatelessWidget {
  final Color color;

  const LoginProgressIndicator(this.color);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: heightOfButtonsAndTextFields * 0.5,
        width: heightOfButtonsAndTextFields * 0.5,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color),
          strokeWidth: 3,
        ),
      ),
    );
  }
}
