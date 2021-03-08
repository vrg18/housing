import 'dart:io';

/// Класс, проверяющий и хранящий платформу (Web/не Web)
/// Используется Provider
class Web {
  late bool _isWeb;

  Web() {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        _isWeb = false;
      } else {
        _isWeb = true;
      }
    } catch (e) {
      _isWeb = true;
    }
  }

  bool get isWeb => _isWeb;
}
