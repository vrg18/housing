import 'package:dio/dio.dart';

String? continueException(DioError error) {
  if (error.response != null) {
    if (error.response!.data != null &&
        error.response!.data is Map<String, dynamic> &&
        (error.response!.data as Map<String, dynamic>).containsKey('value')) {
      return (error.response!.data as Map<String, dynamic>)['value'][0];
    } else {
      return error.response.toString();
    }
  } else {
    return error.error;
  }
}
