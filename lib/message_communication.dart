import 'dart:convert';
import 'package:aquaphonics/websocket_helper.dart';
import 'package:flutter/foundation.dart';

MessageCommunication messageCom = new MessageCommunication();

class MessageCommunication {
  static final MessageCommunication _message = new MessageCommunication._internal();

  factory MessageCommunication() {
    return _message;
  }
  MessageCommunication._internal(){
    sockets.initWebSocket();
    sockets.addListener(_onMessageReceived);
  }

  ObserverList<Function> _connectionListeners = new ObserverList<Function>();
  ObserverList<Function> _commandListeners = new ObserverList<Function>();

  void _onMessageReceived(message) {
  
    var json = jsonDecode(message);

    switch (json["type"]) {
      case "connection":
        _connectionListeners.forEach((Function callback) {
          callback(json);
        });
        break;
      case "command":
        _commandListeners.forEach((Function callback) {
          callback(json);
        });
        break;
      default:
        _commandListeners.forEach((Function callback) {
          callback(message);
        });
    }
  }
  addConnectionListener(Function callback) {
    _connectionListeners.add(callback);
  }
  addCommandListener(Function callback) {
    _commandListeners.add(callback);
  }
  removeConnectionListener(Function callback) {
    _connectionListeners.remove(callback);
  }
  removeCommandListener(Function callback) {
    _commandListeners.remove(callback);
  }

  send(String type, String content) {
    sendRaw(json.encode({type: content}));
  }
  sendRaw(String message) {
    sockets.send(message);
  }
}