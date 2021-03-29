import 'package:dio/dio.dart';
import 'package:housing/data/repository/utils_repository.dart';
import 'package:housing/data/res/properties.dart';
import 'package:housing/domain/address.dart';

class AddressRepository {
  final Dio _dio = dioWithOptionsAndLogger;

  dynamic getAddressesRequest(String token) async {
    disableVerificationCertificate(_dio);

    _dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await _dio.get(apiAddress);
      return _counterContinueOk(response);
    } on DioError catch (e) {
      return continueException(e);
    }
  }

  dynamic _counterContinueOk(response) {
    if (response.statusCode < 300) {
      return (response.data as List<dynamic>).map((e) => Address.fromJson(e));
    } else {
      return response.statusMessage;
    }
  }
}
