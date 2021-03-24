import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:housing/data/service/client_service.dart';
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
            child: isKeyboardVisible
                ? SingleChildScrollView(
                    child: _bodyLoginScreen(context),
                  )
                : _checkForLowScreens(context, height),
          ),
          floatingActionButton: isKeyboardVisible
              ? null
              : SizedBox(
                  width: 80,
                  child: ElevatedButton(
                    child: Text(
                      demoModePress,
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

  Widget _checkForLowScreens(BuildContext context, double height) {
    return tabController.index == 0 && height < contentHeightLoginFirst ||
            tabController.index == 1 && height < contentHeightLoginSecond
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
    context.read<ClientService>().demoAuthentication();
    tabController.index = 2;
  }
}
