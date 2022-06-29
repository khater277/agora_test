import 'package:dio/dio.dart';
import 'package:flutter/material.dart';



class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://fcm.googleapis.com/fcm/send',
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': "application/json",
            'Authorization': 'key=AAAAPiu14Bo:APA91bEnZbM3E7s-0chxSnMdiAgm_XnKVGc3F-mqMtNr6VoJqjzarT-DDLXHuRcggGu5TKcUTXEzbjU2xXU79kZ6f0xeA9Rz61IDrInEpTVNuJ9TI6ItHGGY4OEZ0W1wAzD0wVFFa9Y-',
          }),
    );
  }


  static Future<Response> pushNotification(){

    Map<String,dynamic> data = {
      "to":"dzbZwQuBSMaOTdzC_4qKNo:APA91bGeJ5NPcvi6LXMqtFb9-tUk5f6gHzdOHP6IbL2m4mEtK4Qdem6QXHjKZTFeWV9ejoUE8X2I0C8WhCBJw_GQH-P_cNYzjWma1yBQ0WwNfaGqB4VjW8rI4FG4XiSF4lUt5yi4zyA8",
      "priority":"high",

      "notification":{
        "title":"New Message",
        "body":"user sent you new message",
        "sound": "default"
      },
      "data":{
        "type":"order",
        "id":"1",
        "senderID":"123",
        "phoneNumber":"+201000482644",
        "click_action":"FLUTTER_NOTIFICATION_CLICK"
      }
    };

    return dio!.post('',data: data);
  }
}