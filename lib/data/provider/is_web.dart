import 'dart:io';

/// Класс, проверяющий и хранящий платформу (Web/не Web)
/// Используется Provider
class Web {
  late bool isWeb;

  Web() {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        isWeb = false;
      } else {
        isWeb = true;
      }
    } catch (e) {
      isWeb = true;
    }
  }
}
