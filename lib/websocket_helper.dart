import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'config_manager.dart';

WebSocketListener sockets = new WebSocketListener();


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

    connect() async {
      if (_isOn == true) {
        _listeners.forEach((Function callback) {
          callback('{"type":"connection","content":"server_offline"}');
        });
      }

      final String ip = await Config.getString(ConfigKeys.ip);
      final int port = await Config.getInt(ConfigKeys.port); 
      
      debugPrint("WS:\tConnecting to $ip:$port...");

      _reset();

      try {
        _channel = new IOWebSocketChannel.connect("ws://$ip:$port", protocols: ["client"], pingInterval: Duration(seconds: 5));
        _channel.stream.listen(_onReceptionOfMessageFromServer, onDone: _handleDisconnection, onError: _handleError);
      } catch(e){
        debugPrint("WS: An exception occurred while trying to connect to the WebSocket server.");
        debugPrint(e);
    }
  }

  _handleDisconnection() {
    debugPrint("WS:\tConnection to WebSocket server lost. Reconnecting...");
    if (_timer == null || !_timer.isActive) {
      debugPrint("WS:\tReconnection timer started");
      _timer = new Timer(Duration(seconds: 5), connect);
    }
  }

  _handleError(e) {
    debugPrint("WS:\tError has occured while connecting to the WebSocket Server.");
  }

  _reset() {
    if (_channel != null && _channel.sink != null) {
        _channel.sink.close(WebSocketStatus.normalClosure);
        _channel = null;
        _isOn = false;
    }
  }

  send(String message){
    if (_channel != null){
      if (_channel.sink != null && _isOn){
        debugPrint("WS:\tClient sent data to server: " + message);
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
      debugPrint("WS:\tConnected to server successfully.");

      if (_timer != null && _timer.isActive) {
        debugPrint("WS:\tReconnection timer cancelled");
        _timer.cancel();
      }
    }

    debugPrint("WS:\tReceived data from server: " + message);
    _listeners.forEach((Function callback){
      callback(message);
    });
  }
}