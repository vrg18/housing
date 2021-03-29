import 'package:flutter/foundation.dart';
import 'package:housing/data/repository/address_repository.dart';
import 'package:housing/data/repository/counter_repository.dart';
import 'package:housing/data/repository/counter_type_repository.dart';
import 'package:housing/data/repository/indication_repository.dart';
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
  IndicationRepository _indicationRepository = IndicationRepository();
  bool _isTypesLoaded = false;
  bool _isAddressesLoaded = false;
  bool isAllLoaded = false;
  bool isHistoryLoaded = false;
  late Client _currentClient;
  late List<Counter> counters;
  late List<CounterType> counterTypes;
  late List<Address> addresses;
  late List<Indication> indications;

  // Получить список счетчиков
  Future<String> getCounters(Client client) async {
    _currentClient = client;

    if (!_isTypesLoaded) {
      String returnedType = await _getCounterTypes();
      if (returnedType.isNotEmpty) return returnedType;
    }

    if (!_isAddressesLoaded) {
      String returnedAddress = await _getAddresses();
      if (returnedAddress.isNotEmpty) return returnedAddress;
    }

    if (_currentClient.isDemo) {
      counters = List.from(demoCounters);
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

  // Создать новый адрес
  void addNewAddress(Address address) {
    addresses.add(address);
    notifyListeners();
  }

  // Получить список показаний (историю)
  Future<dynamic> getIndications() async {
    if (_currentClient.isDemo) {
      DateTime dt = DateTime.now();
      indications = [];
      counters.forEach(
        (counter) {
          if (counter.previousValue != null) {
            indications.add(Indication(
              meter: counter.id!,
              value: counter.previousValue!,
              date: DateTime(dt.year, dt.month - 1, dt.day),
            ));
          }
        },
      );
    } else {
      dynamic returned = await _indicationRepository.getIndicationRequest(_currentClient.token!);
      if (returned is Iterable<Indication>) {
        indications = List.from(returned);
      } else {
        return returned;
      }
    }
    isHistoryLoaded = true;
    return '';
  }

  // Получить список показаний (историю) одного счетчика
  List<Indication> getIndicationsOne(int counterId) {
    List<Indication> indicationsOne = List.from(indications.where((e) => e.meter == counterId).toList());
    indicationsOne.sort((a, b) => b.date!.compareTo(a.date!));
    return indicationsOne;
  }

  // Подать новое показание
  Future<String> addNewIndication(Counter counter, String valueS) async {
    int? value = stringToInt(valueS);
    if (value == null) {
      return incorrectValueMessage;
    }
    counters.forEach((countersElement) {
      if (countersElement.id == counter.id) {
        countersElement.previousValue = value;
      }
    });
    Indication indication = Indication(
      meter: counter.id!,
      value: value,
      date: DateTime.now(),
    );
    indications.add(indication);
    notifyListeners();

    if (_currentClient.isDemo) {
      return '';
    } else {
      dynamic returned = await _indicationRepository.postIndicationRequest(_currentClient.token!, indication);
      return returned;
    }
  }

  // Почистить флажки при смене клиента
  void serviceClear() {
    isHistoryLoaded = false;
    isAllLoaded = false;
    _isTypesLoaded = false;
    _isAddressesLoaded = false;
  }

  // Получить список типов счетчиков
  Future<String> _getCounterTypes() async {
    if (_currentClient.isDemo) {
      counterTypes = List.from(demoTypes);
    } else {
      dynamic returned = await _counterTypeRepository.getCounterTypesRequest(_currentClient.token!);
      if (returned is Iterable<CounterType>) {
        counterTypes = List.from(returned);
      } else {
        return returned;
      }
    }
    _fillIconsAndUnits();
    _isTypesLoaded = true;
    return '';
  }

  // Получить список адресов
  Future<String> _getAddresses() async {
    if (_currentClient.isDemo) {
      addresses = List.from(demoAddresses);
    } else {
      dynamic returned = await _addressRepository.getAddressesRequest(_currentClient.token!);
      if (returned is Iterable<Address>) {
        addresses = List.from(returned);
      } else {
        return returned;
      }
    }
    _isAddressesLoaded = true;
    return '';
  }

  // С бэка приходят только ID типов счетчиков, сопоставим с классом CounterType...
  void _fillCounterTypes(List<CounterType> counterTypes) {
    counters.forEach((counter) => counter.counterType = _findCounterType(counter.type));
  }

  // Ищем по типу счетчика (int) тип счетчика (CounterType)
  CounterType? _findCounterType(int type) {
    CounterType? counterType;
    counterTypes.forEach((counterTypes) {
      if (type == counterTypes.id) {
        counterType = counterTypes;
      }
    });
    return counterType;
  }

  // С бэка приходят типы счетчиков без иконок, заполняем сами
  void _fillIconsAndUnits() {
    counterTypes.forEach((counterType) {
      matchOfTypesIconsAndUnits.entries.forEach((indication) {
        if (counterType.title.toLowerCase().contains(indication.key)) {
          counterType.icon = indication.value[0];
          counterType.color = indication.value[1];
        }
      });
    });
  }

  // Строка в int
  int? stringToInt(String valueS) {
    double? valueD = double.tryParse(valueS);
    if (valueD == null) {
      return null;
    }
    return valueD.round();
  }
}
