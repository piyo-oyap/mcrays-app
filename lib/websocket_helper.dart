import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

WebSocketListener sockets = new WebSocketListener();

// TODO: Make this configurable on app
const String _SERVER_ADDRESS = "ws://10.0.0.4:5001";

class WebSocketListener {
  static final WebSocketListener _sockets = new WebSocketListener._internal();

    factory WebSocketListener() {
      return _sockets;
    }

    WebSocketListener._internal();

    IOWebSocketChannel _channel;

    bool _isOn = false;

    ObserverList<Function> _listeners = new ObserverList<Function>();

    initWebSocket() async {
      reset();

      try {
      _channel = new IOWebSocketChannel.connect(_SERVER_ADDRESS, protocols: ["client"]);
      

      // TODO: Implement listeners for closed & error status
      _channel.stream.listen(_onReceptionOfMessageFromServer);

    } catch(e){

    }
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
    _isOn = true;
    _listeners.forEach((Function callback){
      callback(message);
    });
  }
}