import 'package:housing/data/res/properties.dart';
import 'package:housing/data/storage/user_storage.dart';
import 'package:housing/domain/user.dart';

/// Бизнес-логика сущности Пользователь
/// Используется Provider
class CurrentUser {
  late UserStorage _userStorage = UserStorage();
  late User _user;

  get user => _user;

  Future<String> pinCodeRequest(String phone) async {
    return await _userStorage.pinCodeRequest(phone);
  }

  Future<String> authentication(String phone, String password) async {
    dynamic returned = await _userStorage.authentication(phone, password);
    if (returned is User) {
      _user = returned;
      returned = '';
    }
    return returned;
  }

  void demoAuthentication() {
    _user = User(
      demoUserPhoneNumber,
      '',
      true,
    );
  }
}
