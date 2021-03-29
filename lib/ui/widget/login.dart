import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:housing/data/provider/phone_number.dart';
import 'package:housing/data/res/mocks.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:provider/provider.dart';

/// Неизменные "шапка" и "подвал" двух логин-экранов
class LoginScreen extends StatelessWidget {
  final TabController tabController;
  final Widget nestedWidget;

  const LoginScreen(this.tabController, this.nestedWidget);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return KeyboardDismissOnTap(
      child: KeyboardVisibilityBuilder(
        builder: (_, isKeyboardVisible) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(basicBorderSize),
            child: _checkForLowScreens(context, height, isKeyboardVisible),
          ),
          floatingActionButton: isKeyboardVisible || tabController.index != 0
              ? null
              : SizedBox(
                  width: 80,
                  child: ElevatedButton(
                    child: AutoSizeText(
                      demoModePress,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () => _gotoDemoNextScreen(context),
                  ),
                ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      ),
    );
  }

  Widget _checkForLowScreens(BuildContext context, double height, bool isKeyboardVisible) {
    return tabController.index == 0 && height < contentHeightLoginFirst + (isKeyboardVisible ? keyboardHeight : 0) ||
            tabController.index == 1 && height < contentHeightLoginSecond + (isKeyboardVisible ? keyboardHeight : 0)
        ? SingleChildScrollView(
            child: _bodyLoginScreen(context),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_bodyLoginScreen(context)],
          );
  }

  Widget _bodyLoginScreen(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widthWebWrapper * 0.4,
          child: Image.asset(
            logoPicture,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          inputInAccount,
          style: inputInAccountStyle,
        ),
        const SizedBox(height: 30),
        nestedWidget,
        const SizedBox(height: 20),
        TextButton(
          child: Text(
            supportPress,
            style: activeButtonUnderlineLabelStyle,
          ),
          style: bigWhiteButtonStyle,
          onPressed: () => {},
        ),
      ],
    );
  }

  // Переходим на главную страницу приложения в демо-режиме
  void _gotoDemoNextScreen(BuildContext context) {
    context.read<PhoneNumber>().phoneNumber = demoPhoneNumber;
    tabController.index = 1;
  }
}
