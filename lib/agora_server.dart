import 'package:dio/dio.dart';

class AgoraHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          // baseUrl: 'http://192.168.1.5:8080/',
          baseUrl: 'http://192.168.1.2:8082/',
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': "application/json",
          }),
    );
  }

  static Future<Response> getToken() {
    return dio!.post("fetch_rtc_token", data: {
      'channelName': "asd",
      // 'uid':2,
      // 'role':1,
    });

    // return dio!.get("fetch_rtc_token");
  }
}
