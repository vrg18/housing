import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:housing/data/provider/is_web.dart';
import 'package:housing/data/provider/phone_number.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/magnitudes.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginSecond extends StatefulWidget {
  final TabController _tabController;

  LoginSecond(this._tabController, {required Key key}) : super(key: key);

  @override
  _LoginSecondState createState() => _LoginSecondState();
}

class _LoginSecondState extends State<LoginSecond> {
  late final TextEditingController _passwordController;
  late final CountdownTimerController _timerController;
  late bool _isIntroduced;
  late bool _timerIsRunning;
  late bool _isAgrees;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _timerController = CountdownTimerController(
      endTime: DateTime.now().millisecondsSinceEpoch + countdownTimerRepeatedPassword,
      onEnd: onEndTimer,
    );
    _isIntroduced = false;
    _timerIsRunning = true;
    _isAgrees = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          inscriptionEnterPassword + context.watch<PhoneNumber>().phoneNumber,
          textAlign: TextAlign.center,
//          style: inputInAccountStyle,
        ),
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: 150,
            child: TextButton(
              child: Text(inscriptionChangeNumber, style: buttonLabelStyle),
              style: rightSmallerWhiteButtonStyle,
              onPressed: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                widget._tabController.index = 0;
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: heightOfButtonsAndTextFields,
          child: TextField(
            controller: _passwordController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: passwordHint,
            ),
            onChanged: (text) {
              if (text.length == 4) {
                setState(() {
                  _isIntroduced = true;
                });
              } else if (text.length > 4) {
                _passwordController.text = _passwordController.text.substring(0, 4);
                _passwordController.selection = TextSelection.fromPosition(TextPosition(offset: 4));
              } else {
                setState(() {
                  _isIntroduced = false;
                  _isAgrees = false;
                });
              }
            },
          ),
        ),
        _timerIsRunning
            ? SizedBox(
                height: heightOfButtonsAndTextFields * (context.read<Web>().isWeb ? 0.83 : 1),
                child: Center(
                  child: CountdownTimer(
                    controller: _timerController,
                    widgetBuilder: (_, time) => Text(
                      '${time!.min == null ? '0' : time.min}:${time.sec.toString().padLeft(2, '0')}',
                      style: basicBlueColorText,
                    ),
                  ),
                ),
              )
            : TextButton(
                child: Text(inscriptionRepeatedPassword, style: buttonLabelStyle),
                style: context.read<Web>().isWeb ? bigWhiteButtonStyle : smallerWhiteButtonStyle,
                onPressed: () {},
              ),
        const SizedBox(height: 10),
        TextButton(
          child: Text(enterPress, style: buttonLabelStyle),
          onPressed: _isIntroduced && _isAgrees ? () {} : null,
          style: TextButton.styleFrom(
            backgroundColor: _isIntroduced && _isAgrees ? null : inactiveBackgroundColor,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              activeColor: basicBlue,
              value: _isAgrees,
              onChanged: _isIntroduced ? (_) => setState(() => _isAgrees = !_isAgrees) : null,
            ),
            Flexible(
              child: RichText(
                maxLines: 2,
                text: TextSpan(
                  style: TextStyle(fontSize: 13),
                  children: [
                    TextSpan(
                      text: inscriptionAgrees,
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: inscriptionByUserAgreement,
                      style: TextStyle(
                        color: basicBlue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () => launch(userAgreementUrl),
                    ),
                    TextSpan(
                      text: inscriptionAnd,
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: inscriptionPersonalDataPolicy,
                      style: TextStyle(
                        color: basicBlue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () => launch(userAgreementUrl),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  // Когда остановился таймер
  void onEndTimer() {
    setState(() => _timerIsRunning = false);
  }
}
