import 'package:dio/dio.dart';
import 'package:housing/data/repository/utils_repository.dart';
import 'package:housing/data/res/properties.dart';
import 'package:housing/domain/counter_type.dart';

class CounterTypeRepository {
  final Dio _dio = dioWithOptionsAndLogger;

  dynamic getCounterTypesRequest(String token) async {
    _dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await _dio.get(apiMeterTypes);
      return _counterContinueOk(response);
    } on DioError catch (e) {
      return continueException(e);
    }
  }

  dynamic _counterContinueOk(response) {
    if (response.statusCode < 300) {
      return (response.data as List<dynamic>).map((e) => CounterType.fromJson(e));
    } else {
      return response.statusMessage;
    }
  }
}
