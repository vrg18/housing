import 'package:housing/data/repository/client_repository.dart';
import 'package:housing/data/res/mocks.dart';
import 'package:housing/domain/client.dart';

/// Бизнес-логика сущности Клиент
class ClientService {
  ClientRepository _clientStorage = ClientRepository();
  late Client client;

  Future<String> pinCodeRequest(String phone) async {
    return await _clientStorage.pinCodeRequest(phone);
  }

  Future<String> authentication(String phone, String password) async {
    dynamic returned = await _clientStorage.authentication(phone, password);
    if (returned is Client) {
      client = returned;
      return '';
    }
    return returned;
  }

  void demoAuthentication() {
    client = Client(
      phone: demoPhoneNumber,
      isDemo: true,
    );
  }
}
