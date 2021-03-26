import 'package:housing/domain/address.dart';
import 'package:housing/domain/client.dart';
import 'package:housing/domain/counter.dart';
import 'package:housing/domain/counter_type.dart';

/// Моковые данные для демо-режима

// Тестовый телефон
const String testPhone = '+7962632000';
//final String testPhone = '';

// Демо-клиент
final Client demoClient = Client(
  phone: '+79999999999',
  isDemo: true,
);
const String demoPinCode = '999999';

// Типы счетчиков
final List<CounterType> demoTypes = [
  CounterType(
    id: 0,
    title: 'Холодная вода',
    measure: 'м³',
  ),
  CounterType(
    id: 1,
    title: 'Горячая вода',
    measure: 'м³',
  ),
  CounterType(
    id: 2,
    title: 'Газ',
    measure: 'м³',
  ),
  CounterType(
    id: 3,
    title: 'Электросчетчик',
    measure: 'кВт·ч',
  ),
];

// Адреса
final List<Address> demoAddresses = [
  Address(id: 0, street: 'Ленина', house: '17А', apartment: '73', isMain: true),
];

// Счетчики
final List<Counter> demoCounters = [
  Counter(
    id: 0,
    title: 'Холодная вода на Ленина 17А-73',
    type: 0,
    previousValue: 35,
    address: demoAddresses[0],
  ),
  Counter(
    id: 1,
    title: 'Горячая вода на Ленина 17А-73',
    type: 1,
    previousValue: 78,
    address: demoAddresses[0],
  ),
  Counter(
    id: 2,
    title: 'Газ на Ленина 17А-73',
    type: 2,
    previousValue: 448,
    address: demoAddresses[0],
  ),
  Counter(
    id: 3,
    title: 'Электросчетчик на Ленина 17А-73',
    type: 3,
    previousValue: 7183,
    address: demoAddresses[0],
  ),
];
