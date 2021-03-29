import 'package:housing/domain/address.dart';
import 'package:housing/domain/counter.dart';
import 'package:housing/domain/counter_type.dart';
import 'package:housing/domain/request.dart';
import 'package:housing/domain/request_status.dart';

/// Моковые данные для демо-режима

// Тестовый телефон
const String testPhoneNumber = '+7962632000';
//const String testPhoneNumber = '';

// Демо-клиент
const String demoPhoneNumber = '+79999999999';
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

// Статусы заявок
final List<RequestStatus> demoStatuses = [
  RequestStatus(
    id: 0,
    title: 'Новая',
  ),
  RequestStatus(
    id: 1,
    title: 'Принята',
  ),
  RequestStatus(
    id: 2,
    title: 'В работе',
  ),
  RequestStatus(
    id: 3,
    title: 'Отклонена',
  ),
  RequestStatus(
    id: 4,
    title: 'Выполнена',
  ),
];

// Заявки
final List<Request> demoRequests = [
  Request(
    id: 0,
    status: 1,
    subject: 'Ремонт батареи',
    text: 'Течет батарея на кухне',
    surname: 'Иванов',
    name: 'Иван',
    phone: '+79057457454',
    createdAt: DateTime.parse('2021-03-27'),
    address: demoAddresses[0],
  ),
  Request(
    id: 1,
    status: 2,
    subject: 'Не горит лампа',
    text: 'Не горит лампа во 2-ом подъезде на 5-ом этаже',
    surname: 'Петров',
    name: 'Петр',
    patronymic: 'Петрович',
    phone: '+79057457454',
    createdAt: DateTime.parse('2021-03-24'),
    address: demoAddresses[0],
  ),
  Request(
    id: 2,
    status: 3,
    subject: 'Сделайте что-нибудь с шумными соседями',
    text: 'Кричат, ругаются, песни поют, в т.ч. по ночам',
    surname: 'Шариков',
    name: 'Полиграф',
    patronymic: 'Полиграфович',
    phone: '+79057457454',
    createdAt: DateTime.parse('2021-03-20'),
    address: demoAddresses[0],
  ),
  Request(
    id: 3,
    status: 4,
    subject: 'Ремонт уличного фонаря',
    text: 'Не светит фонарь у 2-го подъезда',
    surname: 'Сидоров',
    name: 'Сидор',
    phone: '+79057457454',
    createdAt: DateTime.parse('2021-03-15'),
    address: demoAddresses[0],
  ),
];
