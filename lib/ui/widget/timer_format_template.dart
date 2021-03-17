import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:housing/ui/res/styles.dart';

/// Шаблон для вывода показаний таймера
class TimerFormatTemplate extends StatelessWidget {
  final CurrentRemainingTime time;

  const TimerFormatTemplate(this.time);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: basicBlueColorText,
        children: [
          time.min == null ? TextSpan(text: '0') : TextSpan(text: '${time.min}'),
          TextSpan(text: ':${time.sec.toString().padLeft(2, '0')}'),
        ],
      ),
    );
  }
}
