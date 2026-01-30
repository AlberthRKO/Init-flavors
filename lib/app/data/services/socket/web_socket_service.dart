import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting, nose }

class WebSocketService2 with ChangeNotifier {
  WebSocketService2({
    String chatId = '66cf26df7fc0dfd1aebeee4d',
    int ususarioId = 790,
    String token =
        // ignore: lines_longer_than_80_chars
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyWElqSWxDWTdPOEx6SVkwT2toYzVNa3ZFTnhaNGtkZ2xrVndEWTZpVG45bFNwTEYyWXlLUVhoa0VrMytxNkQxaVZIYThxVUF1cC95OXFRWkduc0xPa1pMY0p6SFJCR0o3TURJNTFCdWo5Vll5U0g0eVgycU9PUGoxTjNzY2xSZEU1S3FSS1IreEVvd1VBRDJzZHdOWjN2SDBEL29BODhHYUlGaEtRQjV5WHI3dVR1aG5GeGpOWUx5MWovbnRXKzFTWHBWUmFpN0k5ZzNtSzdCWlNuM1o1bG9hdU1HOVFybEZtQmlhUGRiQXQrYlUraTUyVEY4aEhxakFIdHA2MTh6WStoQ1craFBDdW9Tbzl4SUYxUHdjOCtVMHBwMDhVMlhDbDkycWlUeDYzZjMrN3BKbnJ4b2g3bzEwK0JXaEpyNDdmNUpIVG5kR3M0ZjhYU0plc3cvb1gxK0tVbE1LVWlNZURqMVl0YVc5NC9JdkNJZFhlZkdkSnphb2pCUk1zeklkVTBRV09INVRjVHlES2pZcVNVckUyV2tWelZGRjhLc3BmY0dSYkxMTko5SFUzSFYwOGQrc2xoa3Rxd0RZeEdLa1ArT3dnNllna2dFQnJ3TjcwOXJJYTFCYjIxTHEvMEhKamtrQzlBZm44OG1xQVRiRkNqdDJaVzdQaGVhUzdPcUV4cjlpSVA3K3F3QjUvOVFTMW5aRDJHeTFyTTFjaVZzdWZaKzBRUjNKdmRIdUxIREttMlBGY3BOUFBMdFR4TTRGdmZOa3NPRGRFOGFjTzhTczRTQ3QwUzlzOEN6cDVDUjQ4dThncGxEcUJ1U0tZTXdPTGxMeWMrTXUwTmVZQVhxWFBBc1hEblZyVy83Mlp6Wit5YkdxdHRtMU5mcHB5ZWtNVFlQYVZRbGNKUSs2NW9KZ0d6ZkxveWNPaWVxODNPcmpIbkk0S2dIR0E3dHlqUU1kYUtYUk81eUZ4N0xCcnpZZWRBcWNhMW4yeXBKTjdBdUMzK2RBSzVaVXJjTUM3ZXBBRzRSSGZGK3Y4MDhyWTVVVytORXY4anFGM1NySE91cFA3MWZldjV0VXkxY0pwVzU5bXlCUkJLbzNHZTdLQUc4d0hqUjl4eUNnYUdFWmQ4Vk9SRnd3QT09IiwiaXYiOiJUZ3ppazR3NVlpN3lWQTNaeUZpcHZ3PT0iLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNzY5Nzk0MjY3LCJleHAiOjE3Njk4ODA2Njd9.2ag_Bxz2dVoQrDQ_yJP-oB_6NX1lbSILkfmT0VyO9n4',
  }) {
    connect(
      chatId: chatId,
      ususarioId: ususarioId,
      token: token,
    );
  }
  ServerStatus _serverStatus = ServerStatus.Connecting;

  IO.Socket? _socket;
  ServerStatus get serverStatus => _serverStatus;

  IO.Socket? get socket => _socket;
  Function? get emit => _socket?.emit;

  String chatId = '66cf26df7fc0dfd1aebeee4d';
  int ususariosId = 790;

  final StreamController<dynamic> _messageStreamController =
      StreamController<dynamic>.broadcast();
  Stream<dynamic> get messageStream => _messageStreamController.stream;

  final StreamController<dynamic> _sentMessageStreamController =
      StreamController<dynamic>.broadcast();
  Stream<dynamic> get sentMessageStream => _sentMessageStreamController.stream;

  void connect({
    String chatId = '66cf26df7fc0dfd1aebeee4d',
    int ususarioId = 790,
    String token =
        // ignore: lines_longer_than_80_chars
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyWElqSWxDWTdPOEx6SVkwT2toYzVNa3ZFTnhaNGtkZ2xrVndEWTZpVG45bFNwTEYyWXlLUVhoa0VrMytxNkQxaVZIYThxVUF1cC95OXFRWkduc0xPa1pMY0p6SFJCR0o3TURJNTFCdWo5Vll5U0g0eVgycU9PUGoxTjNzY2xSZEU1S3FSS1IreEVvd1VBRDJzZHdOWjN2SDBEL29BODhHYUlGaEtRQjV5WHI3dVR1aG5GeGpOWUx5MWovbnRXKzFTWHBWUmFpN0k5ZzNtSzdCWlNuM1o1bG9hdU1HOVFybEZtQmlhUGRiQXQrYlUraTUyVEY4aEhxakFIdHA2MTh6WStoQ1craFBDdW9Tbzl4SUYxUHdjOCtVMHBwMDhVMlhDbDkycWlUeDYzZjMrN3BKbnJ4b2g3bzEwK0JXaEpyNDdmNUpIVG5kR3M0ZjhYU0plc3cvb1gxK0tVbE1LVWlNZURqMVl0YVc5NC9JdkNJZFhlZkdkSnphb2pCUk1zeklkVTBRV09INVRjVHlES2pZcVNVckUyV2tWelZGRjhLc3BmY0dSYkxMTko5SFUzSFYwOGQrc2xoa3Rxd0RZeEdLa1ArT3dnNllna2dFQnJ3TjcwOXJJYTFCYjIxTHEvMEhKamtrQzlBZm44OG1xQVRiRkNqdDJaVzdQaGVhUzdPcUV4cjlpSVA3K3F3QjUvOVFTMW5aRDJHeTFyTTFjaVZzdWZaKzBRUjNKdmRIdUxIREttMlBGY3BOUFBMdFR4TTRGdmZOa3NPRGRFOGFjTzhTczRTQ3QwUzlzOEN6cDVDUjQ4dThncGxEcUJ1U0tZTXdPTGxMeWMrTXUwTmVZQVhxWFBBc1hEblZyVy83Mlp6Wit5YkdxdHRtMU5mcHB5ZWtNVFlQYVZRbGNKUSs2NW9KZ0d6ZkxveWNPaWVxODNPcmpIbkk0S2dIR0E3dHlqUU1kYUtYUk81eUZ4N0xCcnpZZWRBcWNhMW4yeXBKTjdBdUMzK2RBSzVaVXJjTUM3ZXBBRzRSSGZGK3Y4MDhyWTVVVytORXY4anFGM1NySE91cFA3MWZldjV0VXkxY0pwVzU5bXlCUkJLbzNHZTdLQUc4d0hqUjl4eUNnYUdFWmQ4Vk9SRnd3QT09IiwiaXYiOiJUZ3ppazR3NVlpN3lWQTNaeUZpcHZ3PT0iLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNzY5Nzk0MjY3LCJleHAiOjE3Njk4ODA2Njd9.2ag_Bxz2dVoQrDQ_yJP-oB_6NX1lbSILkfmT0VyO9n4',
  }) {
    try {
      const baseUrl = 'https://ms-websocket-ws.dev.mp.gob.bo';
      // var url =
      //     'https://ms-websocket-ws.dev.mp.gob.bo/chat?usuarioId=$ususarioId&aplicacion=roma';
      const url =
          'https://ms-websocket-ws.dev.mp.gob.bo/chat?usuarioId=790&aplicacion=roma';
      // var url = 'wss://ms-websocket-ws.mp.gob.bo';
      // var uri = Uri.parse(url);mp
      _socket = IO.io(
        url,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            // .setPath('/socket.io')
            // .setQuery({'usuarioId': ususarioId, 'aplicacion': 'roma'})
            .setExtraHeaders({'Authorization': token})
            .setAuth({'token': token})
            .build(),
      );

      _socket!.onConnect((_) {
        _serverStatus = ServerStatus.Online;
        _socket!.emit('joinRoom', chatId);
        notifyListeners();
        print('Autenticado y conectado al servidor WebSocket');
      });

      // Escuchar mensajes recibidos
      _socket!.on('receiveMessage', (data) {
        print('Mensaje recibido: $data');
        _messageStreamController.add(data);
      });

      // Escuchar confirmaciones de mensajes enviados
      _socket!.on('sendMessage', (data) {
        print('Mensaje enviado confirmado: $data');
        _sentMessageStreamController.add(data);
      });

      _socket!.onDisconnect((_) {
        _serverStatus = ServerStatus.Offline;
        notifyListeners();
        print('Desconectado');
      });
      _socket!.onError((error) {
        print('=== ERROR DETALLADO ===');
        print('Error en la conexión: $error');
        print('Tipo de error: ${error.runtimeType}');
        _serverStatus = ServerStatus.Offline;
        notifyListeners();

        // Intenta reconectar después de 5 segundos
        Future.delayed(const Duration(seconds: 5), () {
          print('Intentando reconectar...');
          _socket?.connect();
        });
      });

      _socket!.onConnectError((data) {
        print('Error de conexión: $data');
        _serverStatus = ServerStatus.Offline;
        notifyListeners();
      });

      print('Intentando conectar a: $url');
      _socket!.connect();
    } catch (e) {
      print('Error al conectar: $e');
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    }
  }

  // Método para reconectar con nuevo token si es necesario
  /* Future<void> reconnectWithNewToken(String newToken) async {
    disconnect();
    token = newToken;
    connect();
  } */

  // Método para enviar mensajes de forma más limpia
  bool sendMessage({
    required String roomId,
    required Map<String, dynamic> message,
    required int senderId,
  }) {
    if (_socket != null && _serverStatus == ServerStatus.Online) {
      _socket!.emit('sendMessage', {
        'roomId': roomId,
        'message': message,
        'senderId': senderId,
      });
      print('Mensaje enviado a la sala $roomId');
      return true;
    } else {
      print('Error: Socket no conectado o servidor offline');
      return false;
    }
  }

  void disconnect() {
    print('Desconectado');
    _socket!.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
    _socket = null;
  }

  @override
  void dispose() {
    _messageStreamController.close();
    _sentMessageStreamController.close();
    super.dispose();
  }
}
