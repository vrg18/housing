import 'package:flutter/material.dart';
import 'package:housing/data/provider/is_web.dart';
import 'package:housing/data/service/counter_service.dart';
import 'package:housing/domain/counter.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:housing/ui/screen/counter_details.dart';
import 'package:housing/ui/screen/web_wrapper.dart';
import 'package:housing/ui/widget/popup_message.dart';
import 'package:provider/provider.dart';

class CounterCard extends StatelessWidget {
  final Counter counter;

  CounterCard(this.counter);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      context.read<Web>().isWeb ? WebWrapper(CounterDetails(counter)) : CounterDetails(counter)))
          .then((value) => _gotoSaveIndication(context, value)),
      style: counterCardStyle,
      child: Row(
        children: [
          Icon(
            counter.counterType!.icon,
            size: 32,
            color: counter.counterType!.color,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  counter.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: cardNameStyle,
                ),
                Text(
                  counter.previousValue != null
                      ? '${counter.previousValue.toString()} ${counter.counterType!.measure}'
                      : '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: currentReadingsCountersStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _gotoSaveIndication(BuildContext context, dynamic value) async {
    if (value != null && value is String) {
      String error = await context.read<CounterService>().addNewIndication(counter, value);
      if (error.isNotEmpty) {
        popupMessage(context, error);
      }
    }
  }
}
