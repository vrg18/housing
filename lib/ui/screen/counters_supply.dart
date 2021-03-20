import 'package:flutter/material.dart';
import 'package:housing/data/res/mocks.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/widget/counter_card.dart';

/// Страница подачи показаний счетчиков
class CountersSupply extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(basicBorderSize),
      child: GridView.extent(
        maxCrossAxisExtent: wideScreenSizeOver / 2,
        crossAxisSpacing: basicBorderSize,
        mainAxisSpacing: basicBorderSize,
        childAspectRatio: 3,
        children: demoIndications.keys.toList().map((e) => CounterCard(e)).toList(),
      ),
    );
  }
}
