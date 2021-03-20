import 'package:housing/data/res/mocks.dart';
import 'package:housing/domain/counter.dart';
import 'package:housing/domain/indication.dart';

class CounterRepository {

  // Получить последние показания счетчика
  Indication? getLastIndication(Counter counter) {
    return demoIndications[counter]; // todo временно для демо-режима
  }
}
