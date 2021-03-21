import 'package:flutter/material.dart';
import 'package:housing/domain/counter.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/styles.dart';

class CounterCard extends StatelessWidget {
  final Counter counter;

  CounterCard(this.counter);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: [
          Container(
            color: appBarColor,
            padding: EdgeInsets.all(4),
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
                        maxLines: 2,
                        style: counterNameStyle,
                      ),
                      Text(
                        '${counter.previousValue.toString()} ${counter.counterType!.unit}',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned.fill(
            child: MaterialButton(
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
