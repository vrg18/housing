import 'package:housing/data/res/mocks.dart';
import 'package:housing/data/storage/client_storage.dart';
import 'package:housing/domain/client.dart';

/// Бизнес-логика сущности Пользователь
/// Используется Provider
class CurrentClient {
  late ClientStorage _clientStorage = ClientStorage();
  late Client _client;

  get client => _client;

  Future<String> pinCodeRequest(String phone) async {
    return await _clientStorage.pinCodeRequest(phone);
  }

  Future<String> authentication(String phone, String password) async {
    dynamic returned = await _clientStorage.authentication(phone, password);
    if (returned is Client) {
      _client = returned;
      returned = '';
    }
    return returned;
  }

  void demoAuthentication() {
    _client = demoClient;
  }
}
