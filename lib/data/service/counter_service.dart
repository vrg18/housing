import 'package:flutter/foundation.dart';
import 'package:housing/data/repository/address_repository.dart';
import 'package:housing/data/repository/counter_repository.dart';
import 'package:housing/data/repository/counter_type_repository.dart';
import 'package:housing/data/res/mocks.dart';
import 'package:housing/data/res/properties.dart';
import 'package:housing/domain/address.dart';
import 'package:housing/domain/client.dart';
import 'package:housing/domain/counter.dart';
import 'package:housing/domain/counter_type.dart';
import 'package:housing/domain/indication.dart';
import 'package:housing/ui/res/strings.dart';

/// Бизнес-логика сущностей Счетчик и Тип счетчика
class CounterService with ChangeNotifier {
  CounterRepository _counterRepository = CounterRepository();
  CounterTypeRepository _counterTypeRepository = CounterTypeRepository();
  AddressRepository _addressRepository = AddressRepository();
  bool _isTypeLoaded = false;
  bool _isAddressLoaded = false;
  bool isAllLoaded = false;
  late Client _currentClient;
  late List<Counter> counters;
  late List<CounterType> counterTypes;
  late List<Address> addresses;

  // Получить список счетчиков
  Future<String> getCounters(Client client) async {
    _currentClient = client;

    if (!_isTypeLoaded) {
      String returnedType = await _getCounterTypes();
      if (returnedType.isNotEmpty) return returnedType;
    }

    if (!_isAddressLoaded) {
      String returnedAddress = await _getAddresses();
      if (returnedAddress.isNotEmpty) return returnedAddress;
    }

    if (_currentClient.isDemo) {
      counters = List.from(demoCounters.getRange(0, demoCounters.length));
    } else {
      dynamic returned = await _counterRepository.getCountersRequest(_currentClient.token!);
      if (returned is Iterable<Counter>) {
        counters = List.from(returned);
      } else {
        return returned;
      }
    }
    _fillCounterTypes(counterTypes);
    isAllLoaded = true;
    notifyListeners();
    return '';
  }

  // Создать новый счетчик
  Future<String> addNewCounter(Counter counter) async {
    counters.add(counter);
    notifyListeners();

    if (_currentClient.isDemo) {
      counters[counters.length - 1].id = counters[counters.length - 2].id! + 1;
      return '';
    } else {
      dynamic returned = await _counterRepository.postCounterRequest(_currentClient.token!, counter);
      if (returned is Counter) {
        counters[counters.length - 1].id = returned.id;
        counters[counters.length - 1].counterType = _findCounterType(returned.type);
        counters[counters.length - 1].address.id = returned.address.id;
        return '';
      } else {
        return returned;
      }
    }
  }

  // Создать новый счетчик
  void addNewAddress(Address address) {
    addresses.add(address);
    notifyListeners();
  }

  // Подать новое показание
  Future<String> addNewIndication(Counter counter, String valueS) async {
    double? valueD = double.tryParse(valueS);
    if (valueD == null) {
      return incorrectValueMessage;
    }
    int value = valueD.round();
    counters.asMap().values.forEach((c) {
      if (c.id == counter.id) {
        c.previousValue = value;
      }
    });
    notifyListeners();

    if (_currentClient.isDemo) {
      return '';
    } else {
      dynamic returned = await _counterRepository.postIndicationRequest(
          _currentClient.token!,
          Indication(
            meter: counter.id!,
            value: value,
          ));
      return returned;
    }
  }

  /// Почистить флажки при смене клиента
  void serviceClear() {
    isAllLoaded = false;
    _isTypeLoaded = false;
    _isAddressLoaded = false;
  }

  // Получить список типов счетчиков
  Future<String> _getCounterTypes() async {
    if (_currentClient.isDemo) {
      counterTypes = List.from(demoTypes.getRange(0, demoTypes.length));
    } else {
      dynamic returned = await _counterTypeRepository.getCounterTypesRequest(_currentClient.token!);
      if (returned is Iterable<CounterType>) {
        counterTypes = List.from(returned);
      } else {
        return returned;
      }
    }
    _fillIconsAndUnits();
    _isTypeLoaded = true;
    return '';
  }

  // Получить список адресов
  Future<String> _getAddresses() async {
    if (_currentClient.isDemo) {
      addresses = List.from(demoAddresses.getRange(0, demoAddresses.length));
    } else {
      dynamic returned = await _addressRepository.getAddressesRequest(_currentClient.token!);
      if (returned is Iterable<Address>) {
        addresses = List.from(returned);
      } else {
        return returned;
      }
    }
    _isAddressLoaded = true;
    return '';
  }

  // С бэка приходят только ID типов счетчиков, сопоставим с классом CounterType...
  void _fillCounterTypes(List<CounterType> counterTypes) {
    counters.asMap().values.forEach((c) => c.counterType = _findCounterType(c.type));
  }

  // Ищем по типу счетчика (int) тип счетчика (CounterType)
  CounterType? _findCounterType(int type) {
    CounterType? counterType;
    counterTypes.asMap().values.forEach((t) {
      if (type == t.id) {
        counterType = t;
      }
    });
    return counterType;
  }

  // С бэка приходят типы счетчиков без иконок, заполняем сами
  void _fillIconsAndUnits() {
    counterTypes.asMap().values.forEach((t) {
      matchOfTypesIconsAndUnits.entries.forEach((i) {
        if (t.title.toLowerCase().contains(i.key)) {
          t.icon = i.value[0];
          t.color = i.value[1];
        }
      });
    });
  }
}
