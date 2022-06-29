import 'package:agora_test/video_call.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const VideoCallScreen()));
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
