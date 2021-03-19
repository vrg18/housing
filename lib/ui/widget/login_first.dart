import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:housing/data/provider/current_user.dart';
import 'package:housing/data/provider/phone_number.dart';
import 'package:housing/data/repository/phone_number_formatter.dart';
import 'package:housing/data/res/properties.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:housing/ui/widget/popup_message.dart';
import 'package:housing/ui/widget/progress_indicator.dart';
import 'package:provider/provider.dart';

/// Основной содержимое первого логин-экрана
class LoginFirst extends StatefulWidget {
  final TabController tabController;
  final TextEditingController loginController;

  const LoginFirst(this.tabController, this.loginController, {required Key key}) : super(key: key);

  @override
  _LoginFirstState createState() => _LoginFirstState();
}

class _LoginFirstState extends State<LoginFirst> {
  late final PhoneNumberInputFormatter _phoneNumberFormatter;
  late bool _isActiveButton;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _phoneNumberFormatter = PhoneNumberInputFormatter();
    _isActiveButton = widget.loginController.text.length >= 12;
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: heightOfButtonsAndTextFields,
          child: TextField(
            controller: widget.loginController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              _phoneNumberFormatter,
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: loginHint,
            ),
            onChanged: (text) => setState(() => _isActiveButton = text.length >= 12),
            onSubmitted: _isActiveButton ? (_) => _gotoNextScreen() : null,
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          child: _isLoading
              ? LoginProgressIndicator(Colors.white)
              : Text(
                  loginPress,
                  style: buttonLabelStyle,
                ),
          onPressed: _isActiveButton && !_isLoading ? () => _gotoNextScreen() : null,
          style: TextButton.styleFrom(
            backgroundColor: _isActiveButton ? null : inactiveBackgroundColor,
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          child: Text(demoModePress, style: buttonLabelStyle),
          style: bigWhiteButtonStyle,
          onPressed: () => _gotoDemoNextScreen(),
        ),
      ],
    );
  }

  // Инициируем отправку пин-кода и переходим на страницу ввода пин-кода
  Future<void> _gotoNextScreen() async {
    setState(() => _isLoading = true);
    FocusScope.of(context).requestFocus(new FocusNode());
    String error = await context.read<CurrentUser>().pinCodeRequest(widget.loginController.text);
    if (error.isNotEmpty) {
      setState(() => _isLoading = false);
      popupMessage(context, error);
    } else {
      context.read<PhoneNumber>().phoneNumber = widget.loginController.text;
      widget.tabController.index = 1;
    }
  }

  // Переходим на главную страницу приложения в демо-режиме
  void _gotoDemoNextScreen() {
    FocusScope.of(context).requestFocus(new FocusNode());
    context.read<PhoneNumber>().phoneNumber = demoUserPhoneNumber;
    context.read<CurrentUser>().demoAuthentication();
    widget.tabController.index = 2;
  }
}
