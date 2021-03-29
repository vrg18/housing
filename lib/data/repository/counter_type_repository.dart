import 'package:dio/dio.dart';
import 'package:housing/data/repository/utils_repository.dart';
import 'package:housing/data/res/properties.dart';
import 'package:housing/domain/counter_type.dart';

class CounterTypeRepository {
  final Dio _dio = dioWithOptionsAndLogger;

  dynamic getCounterTypesRequest(String token) async {
    disableVerificationCertificate(_dio);

    _dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await _dio.get(apiMeterTypes);
      return _counterTypesContinueOk(response);
    } on DioError catch (e) {
      return continueException(e);
    }
  }

  dynamic _counterTypesContinueOk(response) {
    if (response.statusCode < 300) {
      return (response.data as List<dynamic>).map((counterTypeJson) => CounterType.fromJson(counterTypeJson));
    } else {
      return response.statusMessage;
    }
  }
}
