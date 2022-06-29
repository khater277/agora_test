import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_test/app_brain.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {

  late int _remoteID = 0;
  late RtcEngine _engine;


  Future<void> initAgora()async{
    await [Permission.microphone,Permission.camera].request();
    _engine = await RtcEngine.create(AgoraManager.appId);
    _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess:(String channel,int uid,int elapsed){
          print("joinChannelSuccess to $channel id $uid elapsed $elapsed");
        },
        userJoined: (int uid,int elapsed){
          print("userJoined id $uid elapsed $elapsed");
          setState(()=>_remoteID = uid);
        },
        userOffline: (int uid,UserOfflineReason reason){
          print("userOffline id $uid reason ${reason.toString()}");
          setState(()=>_remoteID = 0);
          Navigator.of(context).pop();
        }
      )
    );
    await _engine.joinChannel(
        AgoraManager.token,
        AgoraManager.channelName,
        null,
        0
    );

  }

  @override
  void initState() {
    initAgora();
    super.initState();
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _renderRemoteVideo(),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150.0),
                child: Container(
                    height: 150, width: 150, child: _renderLocalPreview()),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25.0, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      icon: const Icon(
                        Icons.call_end,
                        size: 44,
                        color: Colors.redAccent,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderLocalPreview(){
    return const RtcLocalView.SurfaceView();
  }

  Widget _renderRemoteVideo(){
    if(_remoteID!=0) {
      return RtcRemoteView.SurfaceView(
      uid: _remoteID,
      channelId: AgoraManager.channelName,
    );
    }else{
      return Text(
        "Calling....",style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      );
    }
  }
}
