import 'package:dio/dio.dart';
import 'package:housing/data/res/properties.dart';
import 'package:housing/domain/address.dart';

class AddressRepository {
  final Dio _dio = dioWithOptionsAndLogger;

  dynamic getAddressesRequest(String token) async {
    _dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await _dio.get(apiAddress);
      return _counterContinueOk(response);
    } on DioError catch (e) {
      return _continueException(e);
    }
  }

  dynamic _counterContinueOk(response) {
    if (response.statusCode < 300) {
      return (response.data as List<dynamic>).asMap().values.map((e) => Address.fromJson(e));
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
