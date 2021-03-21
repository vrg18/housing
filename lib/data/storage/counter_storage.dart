import 'package:dio/dio.dart';
import 'package:housing/data/res/properties.dart';
import 'package:housing/domain/counter.dart';

class CounterStorage {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  );

  dynamic getCountersRequest(String token) async {
    _dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await _dio.get(apiMeter);
      return _counterContinueOk(response);
    } on DioError catch (e) {
      return _continueException(e);
    }
  }

  dynamic _counterContinueOk(response) {
    print('Ответ: ${response.statusCode}/${response.statusMessage}, Содержимое: ${response.data}');
    if (response.statusCode < 300) {
      return (response.data as List<dynamic>).asMap().values.map((e) => Counter.fromJson(e));
    } else {
      return response.statusMessage;
    }
  }

  String _continueException(DioError error) {
    print('Ошибка: ${error.error}');
    if (error.response != null) {
      print('Ответ: ${error.response}');
      return error.response.toString();
    } else {
      return error.error;
    }
  }
}
