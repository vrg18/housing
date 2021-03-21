import 'package:flutter/foundation.dart';
import 'package:housing/data/res/mocks.dart';
import 'package:housing/data/res/properties.dart';
import 'package:housing/data/storage/counter_storage.dart';
import 'package:housing/data/storage/counter_type_storage.dart';
import 'package:housing/domain/client.dart';
import 'package:housing/domain/counter.dart';
import 'package:housing/domain/counter_type.dart';

/// Бизнес-логика сущности Счетчик
class CounterRepository with ChangeNotifier {
  CounterStorage _counterStorage = CounterStorage();
  CounterTypeStorage _counterTypeStorage = CounterTypeStorage();
  final Client _currentClient;
  bool _isTypeLoaded = false;
  bool _isAllLoaded = false;
  late List<Counter> _counters;
  late List<CounterType> _counterTypes;

  CounterRepository(this._currentClient);

  bool get isAllLoaded => _isAllLoaded;

  List<Counter> get counters => _counters;
  List<CounterType> get counterTypes => _counterTypes;

  // Получить список счетчиков
  Future<String> getCounters() async {
    if (!_isTypeLoaded) {
      String returnedType = await getCounterTypes();
      if (returnedType.isNotEmpty) return returnedType;
    }

    if (_currentClient.isDemo) {
      _counters = List.from(demoCounters.getRange(0, demoCounters.length));
      _fillCounterTypes(counterTypes);
      _isAllLoaded = true;
      notifyListeners();
      return '';
    } else {
      dynamic returned = await _counterStorage.getCountersRequest(_currentClient.token!);
      if (returned is Iterable<Counter>) {
        _counters = List.from(returned);
        _fillCounterTypes(counterTypes);
        _isAllLoaded = true;
        notifyListeners();
        return '';
      }
      return returned;
    }
  }

  // Получить список типов счетчиков
  Future<String> getCounterTypes() async {
    if (_currentClient.isDemo) {
      _counterTypes = List.from(demoTypes.getRange(0, demoTypes.length));
      _fillIconsAndUnits();
      _isTypeLoaded = true;
      return '';
    } else {
      dynamic returned = await _counterTypeStorage.getCounterTypesRequest(_currentClient.token!);
      if (returned is Iterable<CounterType>) {
        _counterTypes = List.from(returned);
        _fillIconsAndUnits();
        _isTypeLoaded = true;
        return '';
      }
      return returned;
    }
  }

  // С бэка приходят ID типов счетчиков, сопоставим с классом CounterType...
  void _fillCounterTypes(List<CounterType> counterTypes) {
    _counters.asMap().values.forEach((c) {
      counterTypes.asMap().values.forEach((t) {
        if (c.type == t.id) {
          c.counterType = t;
        }
      });
    });
  }

  // С бэка приходят типы счетчиков без иконок и единиц измерений, заполняем сами
  void _fillIconsAndUnits() {
    _counterTypes.asMap().values.forEach((t) {
      matchOfTypesIconsAndUnits.entries.forEach((i) {
        if (t.title.toLowerCase().contains(i.key)) {
          t.icon = i.value[0];
          t.color = i.value[1];
          t.unit = i.value[2];
        }
      });
    });
  }
}
