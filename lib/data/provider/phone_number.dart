import 'package:flutter/widgets.dart';

/// Класс, хранящий номер телефона пользователя
/// Используется Provider
class PhoneNumber with ChangeNotifier {
  late String _phoneNumber;

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }
}
