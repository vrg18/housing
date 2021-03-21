import 'package:housing/domain/address.dart';
import 'package:housing/domain/client.dart';
import 'package:housing/domain/counter.dart';
import 'package:housing/domain/counter_type.dart';

/// Моковые данные для демо-режима

// Тестовый телефон
//final String testPhone = '+79626320003';
final String testPhone = '';

// Демо-клиент
final Client demoClient = Client(
  phone: '+79999999999',
  isDemo: true,
);

// Типы счетчиков
List<CounterType> demoTypes = [
  CounterType(
    id: 0,
    title: 'Холодная вода',
    // icon: waterIcon,
    // color: basicBlue,
    // unit: 'м³',
  ),
  CounterType(
    id: 1,
    title: 'Горячая вода',
    // icon: waterIcon,
    // color: Colors.red,
    // unit: 'м³',
  ),
  CounterType(
    id: 2,
    title: 'Газ',
    // icon: gasIcon,
    // color: Colors.lightBlueAccent,
    // unit: 'м³',
  ),
  CounterType(
    id: 3,
    title: 'Электросчетчик',
    // icon: electricityIcon,
    // color: Colors.black,
    // unit: 'kW·h',
  ),
];

// Адреса
final Address addressLenin = Address(
  id: 0,
  street: 'Ленина',
  house: '17А',
  apartment: '73',
);

// Счетчики
List<Counter> demoCounters = [
  Counter(
    title: 'Холодная вода на Ленина 17А-73',
    type: 0,
    previousValue: 35,
    address: addressLenin,
  ),
  Counter(
    title: 'Горячая вода на Ленина 17А-73',
    type: 1,
    previousValue: 78,
    address: addressLenin,
  ),
  Counter(
    title: 'Газ на Ленина 17А-73',
    type: 2,
    previousValue: 448,
    address: addressLenin,
  ),
  Counter(
    title: 'Электросчетчик на Ленина 17А-73',
    type: 3,
    previousValue: 7183,
    address: addressLenin,
  ),
];

// // Показания
// final Map<Counter, Indication> demoIndications = {
//   coldWaterLenin: Indication(
//     coldWaterLenin,
//     DateTime.parse('2021-03-20'),
//     15.6,
//   ),
//   hotWaterLenin: Indication(
//     hotWaterLenin,
//     DateTime.parse('2021-03-20'),
//     8.22,
//   ),
//   gasLenin: Indication(
//     gasLenin,
//     DateTime.parse('2021-03-20'),
//     24.33,
//   ),
// };
