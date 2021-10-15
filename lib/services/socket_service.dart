import 'package:chat_app/global/environment.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus{
  OnLine,
  OffLine,
  Connecting,
}

class SocketService with ChangeNotifier{

  ServerStatus _serverStatus = ServerStatus.OnLine;
  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;


  void connect() async {

    final token = await AuthService.getToken();

     _socket = IO.io(Environment.socketUrl, {
      'transports' : ['websocket'],
      'autoConnect': true,
      'forceNew'   : true,
      'extraHeaders' : {
        'x-token' : token
      }
    });
    
    _socket.on('connect', (_) {
      this._serverStatus = ServerStatus.OnLine;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.OffLine;
      notifyListeners();
    });

  }

  void disconnect(){
    this._socket.disconnect();
  }

}