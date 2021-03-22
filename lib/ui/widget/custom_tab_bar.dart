import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/styles.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  final String firstTabLabel;
  final String secondTabLabel;

  const CustomTabBar(this.tabController, this.firstTabLabel, this.secondTabLabel);

  @override
  Size get preferredSize => Size.fromHeight(tabBarHeight + 2);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: TabBar(
        controller: tabController,
        labelColor: basicBlue,
        unselectedLabelColor: unselectedBarColor,
        unselectedLabelStyle: unselectedBarStyle,
        tabs: [
          SizedBox(height: tabBarHeight, child: Tab(text: firstTabLabel)),
          SizedBox(height: tabBarHeight, child: Tab(text: secondTabLabel)),
        ],
      ),
    );
  }
}
