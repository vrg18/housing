import 'package:flutter/material.dart';
import 'package:housing/data/repository/counter_repository.dart';
import 'package:housing/domain/counter.dart';
import 'package:housing/ui/res/styles.dart';

class CounterCard extends StatelessWidget {
  final Counter counter;
  final CounterRepository counterRepository = CounterRepository();

  CounterCard(this.counter);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: [
          Container(
            color: Colors.grey,
            child: Row(
              children: [
                Icon(counter.type.icon),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      counter.name,
                      style: buttonLabelStyle,
                    ),
                    Text(
                      counterRepository.getLastIndication(counter)!.value.toString() + ' ' + counter.type.unit,
//                    style: lightFaintInscriptionStyle,
                    ),
                  ],
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
