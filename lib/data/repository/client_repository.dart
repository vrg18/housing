import 'package:dio/dio.dart';
import 'package:housing/data/repository/utils_repository.dart';
import 'package:housing/data/res/properties.dart';
import 'package:housing/domain/client.dart';

class ClientRepository {
  final Dio _dio = dioWithOptionsAndLogger;

  dynamic pinCodeRequest(String phone) async {
    try {
      var response = await _dio.post(
        apiAuthMobile,
        data: {'mobile': phone},
      );
      return _authContinueOk('', response, false);
    } on DioError catch (e) {
      return continueException(e);
    }
  }

  dynamic authentication(String phone, String password) async {
    try {
      var response = await _dio.post(
        apiAuthCustomToken,
        data: {'mobile': phone, 'token': password, 'agree': true},
      );
      return _authContinueOk(phone, response, true);
    } on DioError catch (e) {
      return continueException(e);
    }
  }

  dynamic _authContinueOk(String phone, response, bool isAuth) {
    if (response.statusCode < 300) {
      if (isAuth) {
        return Client(
          phone: phone,
          token: response.data['access'],
          isDemo: false,
        );
      } else {
        return '';
      }
    } else {
      return response.statusMessage;
    }
  }
}
