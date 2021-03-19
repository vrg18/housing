import 'package:flutter/material.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:housing/ui/screen/counters_history.dart';
import 'package:housing/ui/screen/counters_supply.dart';

/// Верхнее бар-меню показаний счетчиков
class CountersManager extends StatefulWidget {
  @override
  _CountersManagerState createState() => _CountersManagerState();
}

class _CountersManagerState extends State<CountersManager> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(tabBarHeight + 2),
        child: AppBar(
          bottom: TabBar(
            controller: _tabController,
            labelColor: basicBlue,
            unselectedLabelColor: unselectedBarColor,
            unselectedLabelStyle: unselectedBarStyle,
            tabs: [
              SizedBox(height: tabBarHeight, child: Tab(text: supplyCountersLabel)),
              SizedBox(height: tabBarHeight, child: Tab(text: historyCountersLabel)),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CountersSupply(),
          CountersHistory(),
        ],
      ),
    );
  }
}
