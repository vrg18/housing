import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/text_styles.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        body: KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) => isKeyboardVisible
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(basicBorderSize), child: _mainContent(isKeyboardVisible))
              : Padding(
                  padding: const EdgeInsets.all(basicBorderSize),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [_mainContent(isKeyboardVisible)],
                  ),
                ),
        ),
      ),
    );
  }

  Column _mainContent(bool isKeyboardVisible) {
    return Column(
      children: [
        SizedBox(
          width: widthWebWrapper / 2,
          child: Image.asset(
            logoPicture,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 50),
        Text(
          inputInAccount,
          style: inputInAccountStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 50),
        SizedBox(
          height: heightOfButtonsAndTextFields,
          child: TextField(
            key: _key,
            controller: _loginController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: loginHint,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          child: Text(loginPress, style: buttonLabelStyle),
          onPressed: () => {},
        ),
        const SizedBox(height: 10),
        TextButton(
          child: Text(demoModePress, style: buttonLabelStyle),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => Colors.white),
            foregroundColor: MaterialStateProperty.resolveWith<Color>((states) => basicBlue),
          ),
          onPressed: () => {},
        ),
        Divider(),
        TextButton(
          child: Text(
            supportPress,
            style: buttonLabelStyle.merge(
              TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => Colors.white),
            foregroundColor: MaterialStateProperty.resolveWith<Color>((states) => basicBlue),
          ),
          onPressed: () => {},
        ),
      ],
    );
  }
}
