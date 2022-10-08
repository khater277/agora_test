import 'dart:io';

import 'package:agora_test/agora_server.dart';
import 'package:agora_test/api.dart';
import 'package:agora_test/pages/video_call.dart';
import 'package:agora_test/utils/app_brain.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_channel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Message also contained a notification: ${message.notification!.body}');
      }
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return VideoCallScreen(
          channelName: message.data['channelName'],
          token: message.data['token'],
          uid: 4456,
        );
      }));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message.data);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fluent App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.video_call_outlined,
            size: 200,
          ),
          Text(
            "Khater",
            style: Theme.of(context).textTheme.headline3,
          ),
          Text(
            "+201000482644",
            style: Theme.of(context).textTheme.headline6,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    AgoraHelper.getToken().then((value) {
                      print("GET DATA SUCCESS ${value.data['token']}");
                      DioHelper.pushNotification(
                          token: value.data['token'], channelName: 'asd');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoCallScreen(
                                    token: value.data['token'],
                                    channelName: 'asd',
                                    uid: 3,
                                  )));
                    }).catchError((error) {
                      print("GET DATA ERROR ${error.toString()}");
                    });
                  },
                  icon: const Icon(
                    Icons.video_call,
                    size: 44,
                  ),
                  color: Colors.teal,
                ),
                IconButton(
                  onPressed: () async {
                    await player.stop();
                  },
                  icon: const Icon(
                    Icons.phone,
                    size: 35,
                  ),
                  color: Colors.teal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
