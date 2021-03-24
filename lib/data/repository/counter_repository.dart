import 'package:dio/dio.dart';
import 'package:housing/data/res/properties.dart';
import 'package:housing/domain/counter.dart';
import 'package:housing/domain/indication.dart';

class CounterRepository {
  final Dio _dio = dioWithOptionsAndLogger;

  dynamic getCountersRequest(String token) async {
    _dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await _dio.get(apiMeter);
      return _getCountersContinueOk(response);
    } on DioError catch (e) {
      return _continueException(e);
    }
  }

  dynamic postCounterRequest(String token, Counter counter) async {
    _dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await _dio.post(
        apiMeter,
        data: counter.toJson(),
      );
      return _postCounterContinueOk(response);
    } on DioError catch (e) {
      return _continueException(e);
    }
  }

  dynamic postIndicationRequest(String token, Indication indication) async {
    _dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await _dio.post(
        apiValues,
        data: indication.toJson(),
      );
      return _postIndicationContinueOk(response);
    } on DioError catch (e) {
      return _continueException(e);
    }
  }

  dynamic _getCountersContinueOk(response) {
    if (response.statusCode < 300) {
      return (response.data as List<dynamic>).asMap().values.map((e) => Counter.fromJson(e));
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

  dynamic _postIndicationContinueOk(response) {
    if (response.statusCode < 300) {
      return '';
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
