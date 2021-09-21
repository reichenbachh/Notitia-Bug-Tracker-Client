import 'package:flutter/cupertino.dart';
import 'package:notitia/Providers/ProjectProvider.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketInstance {
  static const _url = "http://172.18.176.1:5000";

  Socket _socket = io(_url, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  Socket get getSocketInstance {
    return _socket;
  }

  Future<void> socketInit() async {
    _socket.connect();
  }

  Future<void> closeSocket() async {
    _socket.close();
  }

  Future<void> emitMesssage(Map<String, dynamic> msgMap) async {
    _socket.emit("send-message", msgMap);
  }

  Future<void> fetchMessage(String? id) async {
    _socket.emit("recieve-message", id);
  }
}
