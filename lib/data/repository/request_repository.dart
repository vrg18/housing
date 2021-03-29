import 'package:dio/dio.dart';
import 'package:housing/data/repository/utils_repository.dart';
import 'package:housing/data/res/properties.dart';
import 'package:housing/domain/request.dart';

class RequestRepository {
  final Dio _dio = dioWithOptionsAndLogger;

  dynamic getRequests(String token) async {
    disableVerificationCertificate(_dio);

    _dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await _dio.get(apiTask);
      return _getRequestsContinueOk(response);
    } on DioError catch (e) {
      return continueException(e);
    }
  }

  dynamic postRequest(String token, Request request) async {
    disableVerificationCertificate(_dio);

    _dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await _dio.post(
        apiTask,
        data: request.toJson(),
      );
      return _postRequestsContinueOk(response);
    } on DioError catch (e) {
      return continueException(e);
    }
  }

  dynamic _getRequestsContinueOk(response) {
    if (response.statusCode < 300) {
      return (response.data as List<dynamic>).map((requestJson) => Request.fromJson(requestJson));
    } else {
      return response.statusMessage;
    }
  }

  dynamic _postRequestsContinueOk(response) {
    if (response.statusCode < 300) {
      return Request.fromJson(response.data);
    } else {
      return response.statusMessage;
    }
  }
}