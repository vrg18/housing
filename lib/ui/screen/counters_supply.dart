import 'package:flutter/material.dart';
import 'package:housing/data/repository/counter_repository.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/widget/counter_card.dart';
import 'package:provider/provider.dart';

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
        childAspectRatio: 2,
        children: context.read<CounterRepository>().counters.asMap().values.map((e) => CounterCard(e)).toList(),
      ),
    );
  }
}
