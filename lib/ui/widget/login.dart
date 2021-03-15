import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:housing/data/provider/is_web.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final int _screenNumber;
  final Widget _nestedWidget;

  LoginScreen(this._screenNumber, this._nestedWidget);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return KeyboardDismissOnTap(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(basicBorderSize),
          child: KeyboardVisibilityBuilder(
            builder: (_, isKeyboardVisible) => isKeyboardVisible
                ? SingleChildScrollView(
                    child: _bodyLoginScreen(context),
                  )
                : _screenNumber == 0 && height < contentHeightLoginFirst ||
                        _screenNumber == 1 && height < contentHeightLoginSecond
                    ? SingleChildScrollView(
                        child: _bodyLoginScreen(context),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [_bodyLoginScreen(context)],
                      ),
          ),
        ),
      ),
    );
  }

  Column _bodyLoginScreen(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: widthWebWrapper / 2,
          child: Image.asset(
            logoPicture,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          inputInAccount,
          style: inputInAccountStyle,
        ),
        const SizedBox(height: 40),
        _nestedWidget,
        Divider(
          color: context.read<Web>().isWeb ? null : Colors.black,
        ),
        TextButton(
          child: Text(
            supportPress,
            style: buttonLabelStyle.merge(
              TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          style: bigWhiteButtonStyle,
          onPressed: () => {},
        ),
      ],
    );
  }
}
