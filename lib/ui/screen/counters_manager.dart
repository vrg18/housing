import 'package:flutter/material.dart';
import 'package:housing/data/repository/counter_repository.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:housing/ui/screen/counters_history.dart';
import 'package:housing/ui/screen/counters_supply.dart';
import 'package:housing/ui/widget/popup_message.dart';
import 'package:housing/ui/widget/progress_indicator.dart';
import 'package:provider/provider.dart';

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
      body: Builder(
        builder: (BuildContext context) {
          if (!context.read<CounterRepository>().isAllLoaded) {
            _weReceiveCounters();
          }

          return context.watch<CounterRepository>().isAllLoaded
              ? TabBarView(
                  controller: _tabController,
                  children: [
                    CountersSupply(),
                    CountersHistory(),
                  ],
                )
              : LoginProgressIndicator(basicBlue);
        },
      ),
      floatingActionButton: SizedBox.shrink(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<void> _weReceiveCounters() async {
    String error = await context.read<CounterRepository>().getCounters();
    if (error.isNotEmpty) {
      popupMessage(context, error);
    }
  }
}
