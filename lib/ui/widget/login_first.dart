import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:housing/data/provider/phone_number.dart';
import 'package:housing/data/repository/phone_number_formatter.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:provider/provider.dart';

class LoginFirst extends StatefulWidget {
  final TabController _tabController;
  final TextEditingController _loginController;

  LoginFirst(this._tabController, this._loginController, {required Key key}) : super(key: key);

  @override
  _LoginFirstState createState() => _LoginFirstState();
}

class _LoginFirstState extends State<LoginFirst> {
  late final PhoneNumberInputFormatter _phoneNumberFormatter;
  late bool _isActiveButton;

  @override
  void initState() {
    super.initState();
    _phoneNumberFormatter = PhoneNumberInputFormatter();
    _isActiveButton = widget._loginController.text.length >= 12;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: heightOfButtonsAndTextFields,
          child: TextField(
            controller: widget._loginController,
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
          child: Text(
            loginPress,
            style: buttonLabelStyle,
          ),
          onPressed: _isActiveButton ? () => _gotoNextScreen() : null,
          style: TextButton.styleFrom(
            backgroundColor: _isActiveButton ? null : inactiveBackgroundColor,
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          child: Text(demoModePress, style: buttonLabelStyle),
          style: bigWhiteButtonStyle,
          onPressed: () {},
        ),
      ],
    );
  }

  void _gotoNextScreen() {
    FocusScope.of(context).requestFocus(new FocusNode());
    context.read<PhoneNumber>().phoneNumber = widget._loginController.text;
    widget._tabController.index = 1;
  }
}
