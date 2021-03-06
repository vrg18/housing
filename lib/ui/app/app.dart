import 'package:flutter/material.dart';
import 'package:housing/data/provider/is_web.dart';
import 'package:housing/data/provider/phone_number.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/theme.dart';
import 'package:housing/ui/screen/screen_manager.dart';
import 'package:housing/ui/screen/web_wrapper.dart';
import 'package:provider/provider.dart';

/// Старт приложения
class App extends StatelessWidget {
  @override
  Widget build(context) => MultiProvider(
        providers: [
          Provider<Web>(create: (_) => Web()),
          ChangeNotifierProvider<PhoneNumber>(create: (_) => PhoneNumber()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: Locale('ru', 'RU'),
            title: appTitle,
            theme: mainTheme,
            builder: (context, _) => context.read<Web>().isWeb ? WebWrapper(ScreenManager()) : ScreenManager()),
      );
}
