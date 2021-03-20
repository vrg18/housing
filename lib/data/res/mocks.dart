import 'package:flutter/material.dart';
import 'package:housing/domain/address.dart';
import 'package:housing/domain/counter.dart';
import 'package:housing/domain/indication.dart';
import 'package:housing/domain/type_of_counter.dart';
import 'package:housing/domain/client.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/icons.dart';

/// Моковые данные для демо-режима

// Пользователь
final Client demoClient = Client(
  phone: '+79999999999',
  isDemo: true,
);

// Типы счетчиков
final TypeOfCounter coldWater = TypeOfCounter(
  'Холодная вода',
  waterIcon,
  basicBlue,
  'м³',
);
final TypeOfCounter hotWater = TypeOfCounter(
  'Горячая вода',
  waterIcon,
  Colors.red,
  'м³',
);
final TypeOfCounter gas = TypeOfCounter(
  'Газ',
  gasIcon,
  Colors.lightBlueAccent,
  'м³',
);

// Адреса
final Address addressLenin = Address(
  street: 'Ленина',
  house: '17А',
  apartment: '73',
);

// Счетчики
final Counter coldWaterLenin = Counter(
  'Холодная вода на Ленина 17А-73',
  coldWater,
  demoClient,
  addressLenin,
);
final Counter hotWaterLenin = Counter(
  'Горячая вода на Ленина 17А-73',
  hotWater,
  demoClient,
  addressLenin,
);
final Counter gasLenin = Counter(
  'Газ на Ленина 17А-73',
  gas,
  demoClient,
  addressLenin,
);

// Показания
final Map<Counter, Indication> demoIndications = {
  coldWaterLenin: Indication(
    coldWaterLenin,
    DateTime.parse('2021-03-20'),
    15.6,
  ),
  hotWaterLenin: Indication(
    hotWaterLenin,
    DateTime.parse('2021-03-20'),
    8.22,
  ),
  gasLenin: Indication(
    gasLenin,
    DateTime.parse('2021-03-20'),
    24.33,
  ),
};
