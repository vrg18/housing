import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:housing/data/provider/current_user.dart';
import 'package:housing/data/provider/is_web.dart';
import 'package:housing/data/provider/phone_number.dart';
import 'package:housing/data/res/properties.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:housing/ui/widget/popup_message.dart';
import 'package:housing/ui/widget/progress_indicator.dart';
import 'package:housing/ui/widget/timer_format_template.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// Основной содержимое второго логин-экрана
class LoginSecond extends StatefulWidget {
  final TabController tabController;

  const LoginSecond(this.tabController, {required Key key}) : super(key: key);

  @override
  _LoginSecondState createState() => _LoginSecondState();
}

class _LoginSecondState extends State<LoginSecond> {
  late final TextEditingController _passwordController;
  late final CountdownTimerController _timerController;
  late bool _isIntroduced;
  late bool _timerIsRunning;
  late bool _isAgrees;
  late bool _isLoadingLogin;
  late bool _isLoadingPinCode;

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
    _isLoadingLogin = false;
    _isLoadingPinCode = false;
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          inscriptionEnterPassword + context.watch<PhoneNumber>().phoneNumber,
          textAlign: TextAlign.center,
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
                widget.tabController.index = 0;
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
              if (text.length == pinCodeLength) {
                setState(() {
                  _isIntroduced = true;
                });
              } else if (text.length > 6) {
                _passwordController.text = _passwordController.text.substring(0, pinCodeLength);
                _passwordController.selection = TextSelection.fromPosition(TextPosition(offset: pinCodeLength));
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
                    widgetBuilder: (_, time) => TimerFormatTemplate(time!),
                  ),
                ),
              )
            : TextButton(
                child: _isLoadingPinCode
                    ? LoginProgressIndicator(basicBlue)
                    : Text(inscriptionRepeatedPassword, style: buttonLabelStyle),
                style: context.read<Web>().isWeb ? bigWhiteButtonStyle : smallerWhiteButtonStyle,
                onPressed: _isLoadingLogin ? null : () => _repeatPinCodeRequest(),
              ),
        const SizedBox(height: 10),
        TextButton(
          child: _isLoadingLogin
              ? LoginProgressIndicator(Colors.white)
              : Text(
                  enterPress,
                  style: buttonLabelStyle,
                ),
          onPressed:
              _isIntroduced && _isAgrees && !_isLoadingLogin && !_isLoadingPinCode ? () => _gotoNextScreen() : null,
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

  // Инициируем переотправку пин-кода
  Future<void> _repeatPinCodeRequest() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _isLoadingPinCode = true;
      _passwordController.clear();
      _isIntroduced = false;
      _isAgrees = false;
    });
    String error = await context.read<CurrentUser>().pinCodeRequest(context.read<PhoneNumber>().phoneNumber);
    if (error.isNotEmpty) {
      setState(() => _isLoadingPinCode = false);
      popupMessage(context, error);
    } else {
      setState(() {
        _timerController.endTime = DateTime.now().millisecondsSinceEpoch + countdownTimerRepeatedPassword;
        _timerController.start();
        _timerIsRunning = true;
        _isLoadingPinCode = false;
      });
    }
  }

  // Логинимся с пин-кодом и переходим на главную страницу приложения
  Future<void> _gotoNextScreen() async {
    setState(() => _isLoadingLogin = true);
    FocusScope.of(context).requestFocus(new FocusNode());
    String error = await context.read<CurrentUser>().authentication(
          context.read<PhoneNumber>().phoneNumber,
          _passwordController.text,
        );
    if (error.isNotEmpty) {
      setState(() => _isLoadingLogin = false);
      popupMessage(context, error);
    } else {
      widget.tabController.index = 2;
    }
  }
}
