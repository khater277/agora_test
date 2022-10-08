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


  static Future<Response> pushNotification({
  required String token,
  required String channelName,
}){
    Map<String,dynamic> data = {
      "to":"f6Pr-8neTaiBaNNwIQyzU5:APA91bEwD-BJm_dCDWqUEqx8AsfaFe8kVEHPuoxQJ2_TGATia1Abt2qOLn7BFUCFFerHHU3io8QL8-mJKnd2xXDudIDHQjUlZvS5rTltHGbzQbmEVK0h63ir9ItYpz7lQZ-DDbd86yhD",
      "priority":"high",
      "notification":{
        "title":"New Message",
        "body":"user sent you new message",
        "sound": "default"
      },
      "data":{
        "type":"order",
        "token":token,
        "channelName":channelName,
        "id":"1",
        "senderID":"123",
        "phoneNumber":"+201000482644",
        "click_action":"FLUTTER_NOTIFICATION_CLICK"
      }
    };

    return dio!.post('',data: data);
  }
}