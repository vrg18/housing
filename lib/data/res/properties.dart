import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:housing/ui/res/colors.dart';
import 'package:housing/ui/res/icons.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Настройки доступа к Backend и пр.

const int pinCodeLength = 6;
const int countdownTimerRepeatedPinCode = 61 * 1000; // 61 секунда

const String apiAuthMobile = '/api/v1/auth/mobile';
const String apiAuthCustomToken = '/api/v1/auth/customtoken';
const String apiMeter = '/api/v1/meter';
const String apiMeterTypes = '/api/v1/metertypes';

// Dio с опциями и логгером
final Dio dioWithOptionsAndLogger = Dio(BaseOptions(
    baseUrl: env['BASE_URL']!, receiveDataWhenStatusError: true, connectTimeout: 5000, receiveTimeout: 3000))
  ..interceptors.add(
    PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 120),
  );

// Соответствия типов счетчиков, иконок и единиц измерений
final Map<String, List<dynamic>> matchOfTypesIconsAndUnits = {
  'хол': [waterIcon, basicBlue, 'м³'],
  'гор': [waterIcon, Colors.red, 'м³'],
  'газ': [gasIcon, Colors.lightBlueAccent, 'м³'],
  'электр': [electricityIcon, Colors.black, 'kW·h'],
};
