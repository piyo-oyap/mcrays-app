import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

WebSocketListener sockets = new WebSocketListener();

// TODO: Make this configurable on app
const String _SERVER_ADDRESS = "ws://10.0.0.33:5001";

class WebSocketListener {
  static final WebSocketListener _sockets = new WebSocketListener._internal();
    factory WebSocketListener() {
      return _sockets;
    }

    WebSocketListener._internal();
    IOWebSocketChannel _channel;
    bool _isOn = false;

    Timer _timer;

    ObserverList<Function> _listeners = new ObserverList<Function>();

    initWebSocket() async {
      debugPrint("Connecting to $_SERVER_ADDRESS...");

      reset();

      try {
        // TODO: adjust ping interval
        _channel = new IOWebSocketChannel.connect(_SERVER_ADDRESS, protocols: ["client"], pingInterval: Duration(seconds: 6));
        

        // TODO: Implement listeners for closed & error status
        _channel.stream.listen(_onReceptionOfMessageFromServer, onDone: _handleDisconnection, onError: _handleError);

      } catch(e){
        debugPrint("An exception occurred while trying to connect to the WebSocket server.");
        debugPrint(e);
    }
  }

  _handleDisconnection() {
    debugPrint("Connection to WebSocket server lost. Reconnecting...");
    if (_timer == null || !_timer.isActive) {
      _timer = new Timer(Duration(seconds: 5), initWebSocket);
    }
  }

  _handleError(e) {
    debugPrint("Error has occured while connecting to the WebSocket Server.");
  }

  reset() {
    if (_channel != null && _channel.sink != null) {
        _channel.sink.close();
        _isOn = false;
    }
  }

  send(String message){
    if (_channel != null){
      if (_channel.sink != null && _isOn){
        debugPrint("Client sent data to server: " + message);
        _channel.sink.add(message);
      }
    }
  }

  addListener(Function callback){
    _listeners.add(callback);
  }
  removeListener(Function callback){
    _listeners.remove(callback);
  }

  _onReceptionOfMessageFromServer(message){
    if (!_isOn) {
      _isOn = true;
      debugPrint("Connected to server successfully.");
    }
    debugPrint("Received data from server: " + message);
    _listeners.forEach((Function callback){
      callback(message);
    });
  }
}