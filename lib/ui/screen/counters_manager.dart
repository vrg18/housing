import 'package:flutter/material.dart';
import 'package:housing/data/service/counter_service.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/screen/counters_history.dart';
import 'package:housing/ui/screen/counters_supply.dart';
import 'package:housing/ui/widget/custom_tab_bar.dart';
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
      appBar: CustomTabBar(_tabController, supplyCountersLabel, historyCountersLabel),
      body: Builder(
        builder: (BuildContext context) {
          if (!context.read<CounterService>().isAllLoaded) {
            _weReceiveCounters();
          }

          return context.watch<CounterService>().isAllLoaded
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
    String error = await context.read<CounterService>().getCounters();
    if (error.isNotEmpty) {
      popupMessage(context, error);
    }
  }
}
