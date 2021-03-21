import 'package:flutter/material.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/icons.dart';

/// Настройки доступа к Backend и пр.

const int pinCodeLength = 6;
const String baseUrl = 'https://brain4you.ru';
const String apiAuthMobile = '/api/v1/auth/mobile';
const String apiAuthCustomToken = '/api/v1/auth/customtoken';
const String apiMeter = '/api/v1/meter';
const String apiMeterTypes = '/api/v1/metertypes';

const int countdownTimerRepeatedPinCode = 61 * 1000; // 61 секунда

// Соответствия типов счетчиков, иконок и единиц измерений
final Map<String, List<dynamic>> matchOfTypesIconsAndUnits = {
  'хол': [waterIcon, basicBlue, 'м³'],
  'гор': [waterIcon, Colors.red, 'м³'],
  'газ': [gasIcon, Colors.lightBlueAccent, 'м³'],
  'электр': [electricityIcon, Colors.black, 'kW·h'],
};