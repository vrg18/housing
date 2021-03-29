import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:housing/domain/indication.dart';
import 'package:housing/ui/res/icons.dart';
import 'package:housing/ui/res/sizes.dart';
import 'package:housing/ui/res/strings.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:housing/ui/widget/top_bar.dart';

class CounterHistory extends StatelessWidget {
  final String counterTitle;
  final List<Indication> indications;

  const CounterHistory(this.counterTitle, this.indications);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        mainIcon: backIcon,
        mainCallback: () => Navigator.pop(context),
        iconMessage: backTooltipMessage,
      ),
      body: Padding(
        padding: const EdgeInsets.all(basicBorderSize),
        child: Column(
          children: [
            AutoSizeText(
              counterTitle,
              style: inputInAccountStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Flexible(
              child: ListView(
                children: indications.map((i) => _historyItem(i)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _historyItem(Indication indication) {
    return Material(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Spacer(),
            Flexible(
              flex: 2,
              child: Text(
                dateFormatter.format(indication.date!),
                style: cardNameStyle,
              ),
            ),
            Spacer(),
            Flexible(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  indication.value.toString(),
                  style: cardNameStyle,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
