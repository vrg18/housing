import 'package:dio/dio.dart';
import 'package:housing/data/res/properties.dart';
import 'package:housing/domain/user.dart';

class UserStorage {
  final Dio _dioAuth = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  );

  dynamic pinCodeRequest(String phone) async {
    try {
      var response = await _dioAuth.post(
        apiAuthMobile,
        data: {'mobile': phone},
      );
      return _authContinueOk('', response, false);
    } on DioError catch (e) {
      return _continueException(e);
    }
  }

  dynamic authentication(String phone, String password) async {
    try {
      var response = await _dioAuth.post(
        apiAuthCustomToken,
        data: {'mobile': phone, 'token': password, 'agree': true},
      );
      return _authContinueOk(phone, response, true);
    } on DioError catch (e) {
      return _continueException(e);
    }
  }

  dynamic _authContinueOk(String phone, response, bool isAuth) {
//    print('Ответ: ${response.statusCode}/${response.statusMessage}, Содержимое: ${response.data}');
    if (response.statusCode < 300) {
      if (isAuth) {
        return User(
          phone,
          response.data['access'],
          false,
        );
      } else {
        return '';
      }
    } else {
      return response.statusMessage;
    }
  }

  String _continueException(DioError error) {
    if (error.response != null) {
      return error.response.toString();
    } else {
      return error.error;
    }
  }
}
