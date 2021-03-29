import 'package:dio/dio.dart';
import 'package:housing/data/repository/utils_repository.dart';
import 'package:housing/data/res/properties.dart';
import 'package:housing/domain/request_status.dart';

class RequestStatusRepository {
  final Dio _dio = dioWithOptionsAndLogger;

  dynamic getRequestStatusesRequest(String token) async {
    disableVerificationCertificate(_dio);

    _dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await _dio.get(apiTaskStatus);
      return _requestStatusesContinueOk(response);
    } on DioError catch (e) {
      return continueException(e);
    }
  }

  dynamic _requestStatusesContinueOk(response) {
    if (response.statusCode < 300) {
      return (response.data as List<dynamic>).map((e) => RequestStatus.fromJson(e));
    } else {
      return response.statusMessage;
    }
  }
}