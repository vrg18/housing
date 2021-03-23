import 'package:flutter/material.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/screen/requests_create.dart';
import 'package:housing/ui/screen/requests_history.dart';
import 'package:housing/ui/widget/custom_tab_bar.dart';

/// Верхнее бар-меню заявок
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
   }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTabBar(_tabController, createRequestsLabel, historyRequestsLabel),
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
