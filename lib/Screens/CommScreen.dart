import 'package:flutter/material.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:notitia/Providers/ProjectProvider.dart';
import 'package:notitia/Screens/VideoCallPage.dart';
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
    print("yyyyyyyyyyyyyyyyy");
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);

    // final String chanell = Provider.of<ProjectProvider>(context).ge

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoCallPage(
            appID: "c7e1ccdaafeb4ff886c9653d018e50d3",
            channelName: "aadsdasd",
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Communications"),
      ),
      body: DashChat(
          trailing: [
            GestureDetector(
              onTap: () => onJoin(),
              child: Icon(Icons.video_call_outlined),
            )
          ],
          onSend: (_) {},
          messages: [
            ChatMessage(
              text: "Hello",
              user: ChatUser(
                name: "Jhon Doe",
                uid: "xxxxxxxxx",
              ),
              createdAt: DateTime.now(),
            )
          ],
          user: ChatUser(
            name: "Jhon Doe",
            uid: "xxxxxxxxx",
          )),
    );
  }
}
