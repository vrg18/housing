import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:housing/data/provider/phone_number.dart';
import 'package:housing/data/res/mocks.dart';
import 'package:housing/data/res/properties.dart';
import 'package:housing/data/service/client_service.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/icons.dart';
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
  late bool _isDemo;

  @override
  void initState() {
    super.initState();
    _isDemo = context.read<PhoneNumber>().phoneNumber == demoClient.phone;
    _passwordController = TextEditingController(text: _isDemo ? demoPinCode : '');
    _timerController = CountdownTimerController(
      endTime: DateTime.now().millisecondsSinceEpoch + countdownTimerRepeatedPinCode,
      onEnd: onEndTimer,
    );
    _isIntroduced = _isDemo;
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Tooltip(
              message: inscriptionChangeNumber,
              child: IconButton(
                iconSize: 32,
                icon: Icon(
                  backIcon,
                  color: basicBlue,
                ),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  widget.tabController.index = 0;
                },
              ),
            ),
            Flexible(
              child: AutoSizeText(
                inscriptionEnterPassword + context.watch<PhoneNumber>().phoneNumber,
                maxLines: 2,
                textAlign: TextAlign.right,
              ),
            )
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Flexible(
              flex: 2,
              child: SizedBox(
                height: heightOfButtonsAndTextFields,
                child: Stack(
                  children: [
                    TextField(
                      enabled: !_isDemo,
                      controller: _passwordController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        hintText: passwordHint,
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                      onEditingComplete: () => FocusScope.of(context).nextFocus(),
                      onChanged: (text) {
                        if (text.length == pinCodeLength) {
                          setState(() {
                            _isIntroduced = true;
                          });
                        } else if (text.length > pinCodeLength) {
                          _passwordController.text = _passwordController.text.substring(0, pinCodeLength);
                          _passwordController.selection =
                              TextSelection.fromPosition(TextPosition(offset: pinCodeLength));
                        } else {
                          setState(() {
                            _isIntroduced = false;
                            _isAgrees = false;
                          });
                        }
                      },
                    ),
                    Positioned(
                      right: 0,
                      child: SizedBox(
                        width: heightOfButtonsAndTextFields,
                        height: heightOfButtonsAndTextFields,
                        child: Center(
                          child: _timerIsRunning
                              ? CountdownTimer(
                                  controller: _timerController,
                                  widgetBuilder: (_, time) => TimerFormatTemplate(time!),
                                )
                              : _isLoadingPinCode
                                  ? LoginProgressIndicator(basicBlue)
                                  : Tooltip(
                                      message: inscriptionRepeatedPassword,
                                      child: IconButton(
                                        iconSize: 32,
                                        icon: Icon(
                                          Icons.replay,
                                          color: basicBlue,
                                        ),
                                        onPressed: _isLoadingLogin || _isDemo ? null : () => _repeatPinCodeRequest(),
                                      ),
                                    ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
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
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          child: _isLoadingLogin
              ? LoginProgressIndicator(Colors.white)
              : Text(
                  _isDemo ? enterPressDemo : enterPress,
                  style: _isIntroduced && _isAgrees ? activeButtonLabelStyle : inactiveButtonLabelStyle,
                ),
          onPressed:
              _isIntroduced && _isAgrees && !_isLoadingLogin && !_isLoadingPinCode ? () => _gotoNextScreen() : null,
          style: TextButton.styleFrom(
            backgroundColor: _isIntroduced && _isAgrees ? null : inactiveBackgroundColor,
          ),
        ),
      ],
    );
  }

  // Когда остановился таймер
  void onEndTimer() {
    setState(() => _timerIsRunning = false);
  }

  // Инициируем переотправку пин-кода
  Future<void> _repeatPinCodeRequest() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoadingPinCode = true;
      _passwordController.clear();
      _isIntroduced = false;
      _isAgrees = false;
    });
    String error = await context.read<ClientService>().pinCodeRequest(context.read<PhoneNumber>().phoneNumber);
    if (error.isNotEmpty) {
      setState(() => _isLoadingPinCode = false);
      popupMessage(context, error);
    } else {
      setState(() {
        _timerController.endTime = DateTime.now().millisecondsSinceEpoch + countdownTimerRepeatedPinCode;
        _timerController.start();
        _timerIsRunning = true;
        _isLoadingPinCode = false;
      });
    }
  }

  // Логинимся с пин-кодом и переходим на главную страницу приложения
  Future<void> _gotoNextScreen() async {
    if (!_isDemo) {
      setState(() => _isLoadingLogin = true);
      FocusScope.of(context).unfocus();
      String error = await context.read<ClientService>().authentication(
            context.read<PhoneNumber>().phoneNumber,
            _passwordController.text,
          );
      if (error.isNotEmpty) {
        setState(() => _isLoadingLogin = false);
        popupMessage(context, error);
      } else {
        widget.tabController.index = 2;
      }
    } else {
      widget.tabController.index = 2;
    }
  }
}
