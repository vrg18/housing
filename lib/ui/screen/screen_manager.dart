import 'package:flutter/material.dart';
import 'package:housing/ui/screen/bottom_bar_manager.dart';
import 'package:housing/ui/widget/login.dart';
import 'package:housing/ui/widget/login_first.dart';
import 'package:housing/ui/widget/login_second.dart';

/// TabController для навигации между экранами с эффектом сдвига вбок
class ScreenManager extends StatefulWidget {
  @override
  _ScreenManagerState createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final GlobalKey _firstKey;
  late final GlobalKey _secondKey;
  late final TextEditingController _loginController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
    _firstKey = GlobalKey();
    _secondKey = GlobalKey();
    _loginController = TextEditingController(); //text: '+79053490432');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          LoginScreen(_tabController.index, LoginFirst(_tabController, _loginController, key: _firstKey)),
          LoginScreen(_tabController.index, LoginSecond(_tabController, key: _secondKey)),
          BottomBarManager(_tabController, _loginController),
        ],
      ),
    );
  }
}
