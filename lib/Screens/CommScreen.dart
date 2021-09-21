import 'package:flutter/material.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:notitia/Providers/AuthProvider.dart';
import 'package:notitia/Providers/ProjectProvider.dart';
import 'package:notitia/Screens/VideoCallPage.dart';
import 'package:notitia/utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class CommScreen extends StatefulWidget {
  const CommScreen({Key? key}) : super(key: key);

  @override
  _CommScreenState createState() => _CommScreenState();
}

class _CommScreenState extends State<CommScreen> {
  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  Future<void> onJoin() async {
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoCallPage(
            appID: "e79f6d41892f485aa12ea9ffa83edac7",
            channelName: "chanell1",
          ),
        ));
  }

  late final authProv = Provider.of<AuthProvider>(context, listen: false);
  late final providerData =
      Provider.of<ProjectProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Spacer(
              flex: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.video_call,
                          size: 40,
                        ),
                        Text(
                          "Start Video Call",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26),
                        ),
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: primCol,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  )),
            ),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
