import 'package:dio/dio.dart';
import 'package:housing/data/repository/utils_repository.dart';
import 'package:housing/data/res/properties.dart';
import 'package:housing/domain/indication.dart';

class IndicationRepository {
  final Dio _dio = dioWithOptionsAndLogger;

  dynamic getIndicationRequest(String token) async {
    _dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await _dio.get(apiValues);
      return _getIndicationContinueOk(response);
    } on DioError catch (e) {
      return continueException(e);
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
      return continueException(e);
    }
  }

  dynamic _getIndicationContinueOk(response) {
    if (response.statusCode < 300) {
      return (response.data as List<dynamic>).map((i) => Indication.fromJson(i));
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
}
