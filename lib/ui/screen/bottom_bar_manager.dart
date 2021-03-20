import 'package:flutter/material.dart';
import 'package:housing/data/provider/current_client.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/screen/counters_manager.dart';
import 'package:housing/ui/screen/requests_manager.dart';
import 'package:housing/ui/widget/top_bar.dart';
import 'package:provider/provider.dart';

/// Основное нижнее меню
class BottomBarManager extends StatefulWidget {
  final TabController tabController;
  final TextEditingController loginController;

  const BottomBarManager(this.tabController, this.loginController);

  @override
  _BottomBarManagerState createState() => _BottomBarManagerState();
}

class _BottomBarManagerState extends State<BottomBarManager> {
  int _selectedPage = 0;
  final List<Widget> _pages = [
    CountersManager(),
    RequestsManager(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        context.read<CurrentClient>().client.phone,
        _returnToLogin,
      ),
      body: IndexedStack(
        index: _selectedPage,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        fixedColor: basicBlue,
        unselectedItemColor: unselectedBarColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.network_check),
            label: tooltipCounters,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: tooltipRequests,
          ),
        ],
      ),
    );
  }

  /// Метод переключает страницы BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() => _selectedPage = index);
  }

  /// Возврат на страницу логина
  void _returnToLogin() {
    widget.loginController.clear();
    widget.tabController.index = 0;
  }
}
