import 'package:agora_test/agora_server.dart';
import 'package:agora_test/api.dart';
import 'package:agora_test/pages/video_call.dart';
import 'package:agora_test/utils/app_brain.dart';
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
        print('Message also contained a notification: ${message.notification!.body}');
      }
      // Navigator.of(context).push(
      //     MaterialPageRoute(builder: (BuildContext context) {
      //       return VideoCallScreen(channelName: message.data['cannelName'],);
      //     })
      // );
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fluent App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(150.0),
            child: Image.network(
              "https://play-lh.googleusercontent.com/ZpQcKuCwbQnrCgNpsyUsgDjuBUnpcIBkVrPSDKS9LOJTAW1kxMsu6cLltOSUODjiEQ=w500-h280-rw",
              height: 200.0,
              width: 200.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            "Amar Awni",
            style: Theme.of(context).textTheme.headline3,
          ),
          Text(
            "+90 555 000 00 00",
            style: Theme.of(context).textTheme.headline6,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => VideoCallScreen()));
                    AgoraHelper.getToken().then((value){
                      print("GET DATA SUCCESS ${value.data['token']}");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoCallScreen(
                                token: value.data['token'],
                                channelName: 'asd',
                                uid: 3,
                              )));
                    }).catchError((error){
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
                  onPressed: () {

                    // Navigator.push(
                    // context,
                    // MaterialPageRoute(
                    // builder: (context) => AudioCallScreen()));
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