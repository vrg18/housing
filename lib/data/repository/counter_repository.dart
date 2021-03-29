import 'package:dio/dio.dart';
import 'package:housing/data/repository/utils_repository.dart';
import 'package:housing/data/res/properties.dart';
import 'package:housing/domain/counter.dart';

class CounterRepository {
  final Dio _dio = dioWithOptionsAndLogger;

  dynamic getCountersRequest(String token) async {
    disableVerificationCertificate(_dio);

    _dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await _dio.get(apiMeter);
      return _getCountersContinueOk(response);
    } on DioError catch (e) {
      return continueException(e);
    }
  }

  dynamic postCounterRequest(String token, Counter counter) async {
    disableVerificationCertificate(_dio);

    _dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await _dio.post(
        apiMeter,
        data: counter.toJson(),
      );
      return _postCounterContinueOk(response);
    } on DioError catch (e) {
      return continueException(e);
    }
  }

  dynamic _getCountersContinueOk(response) {
    if (response.statusCode < 300) {
      return (response.data as List<dynamic>).map((counterJson) => Counter.fromJson(counterJson));
    } else {
      return response.statusMessage;
    }
  }

  dynamic _postCounterContinueOk(response) {
    if (response.statusCode < 300) {
      return Counter.fromJson(response.data);
    } else {
      return response.statusMessage;
    }
  }
}
