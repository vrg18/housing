import 'package:flutter/material.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:housing/ui/screen/requests_create.dart';
import 'package:housing/ui/screen/requests_history.dart';

/// верхнее бар-меню заявок
class RequestsManager extends StatefulWidget {
  @override
  _RequestsManagerState createState() => _RequestsManagerState();
}

class _RequestsManagerState extends State<RequestsManager> with SingleTickerProviderStateMixin {
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
              SizedBox(height: tabBarHeight, child: Tab(text: createRequestsLabel)),
              SizedBox(height: tabBarHeight, child: Tab(text: historyRequestsLabel)),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          RequestsCreate(),
          RequestsHistory(),
        ],
      ),
    );
  }
}
