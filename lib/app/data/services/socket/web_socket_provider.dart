import 'package:flutter/material.dart';
import 'package:gw_sms/app/data/services/socket/web_socket_service.dart';

class WebSocketProvider with ChangeNotifier {
  final WebSocketService2 _webSocketService = WebSocketService2();
  bool _isConnected = false;

  bool get isConnected => _isConnected;

  Future<void> connect(String baseUrl) async {
    try {
      _webSocketService.connect();
      _isConnected = true;
      notifyListeners();
    } catch (e) {
      _isConnected = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> disconnect() async {
    _webSocketService.disconnect();
    _isConnected = false;
    notifyListeners();
  }
}
