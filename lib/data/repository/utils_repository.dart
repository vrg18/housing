/*
import 'dart:io';
import 'package:dio/adapter.dart';
*/
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

// Отключение проверки сертификата, для Web не работает
void disableVerificationCertificate(Dio dio) {
/*
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  };
*/
}
