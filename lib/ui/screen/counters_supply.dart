import 'package:flutter/material.dart';
import 'package:housing/data/service/counter_service.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/widget/counter_card_elevated.dart';
import 'package:provider/provider.dart';

/// Страница подачи показаний счетчиков
class CountersSupply extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(basicBorderSize),
      child: GridView.extent(
        maxCrossAxisExtent: wideScreenSizeOver / 2,
        crossAxisSpacing: basicBorderSize,
        mainAxisSpacing: basicBorderSize,
        childAspectRatio: 2,
        children: context.read<CounterService>().counters.asMap().values.map((e) => CounterCardElevated(e)).toList(),
      ),
    );
  }
}
