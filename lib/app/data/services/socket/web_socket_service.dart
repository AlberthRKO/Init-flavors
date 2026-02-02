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
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ0ZnoyYldMY1Q4NGZUQm9aU0ZkbkVJSFVqUW03eWRDZFR1dDk4K3Vkd0p4OXRTY1dFZEY4VGExajQ0c0g3RWxyYWFrdWtHYnRFVzJIeUt4cEk5NnJ6QVpHZDVVYU8vRU9HdjlUVXB5VEFKTTc3S3dXMkdQUHVVN0lNbm53K1VCK3YxdDJ0aFYrWU5RTUtsVU1OR2ZuWnUvUEpJdlpOMFBLbCttc0FZMThuUks2TFlRUHpGTjUxVEk4L1JhRndZOWdnckZtWExZZWZSeTk3TXpBQStwekE4VkYwU0szamd0ZGpKUFRNTFl3ZGUrQXEyNW5EL0hSaXZqSHNLaGFvbjZmZG5FcnRIdisvQ21CQXR6TGRPS2RCZmUrMm5UWnpBbjhXMStvWEt5YTEwN3ZvKzFNZjI5ZElvV2dzSlF1bDcxOXRDdnoyN0hCUzQxOCt2TW9jcEZ2bmx6S3A5Y05JdkExdEdIMVlxdXlKOTJlQlJqZ1MvMGIyanc2a0k2dGo2Q3UwaUpCNU5uUVgvNnVpc3QyemZ5dGdRT2crYmZlTDY0VW5ZTFRITlNDQitRbFhsTVY3bWNNYzVHT2RKSGIwbUFaeElxSTdKdkxtck1lZkpGRDVkRk5CczlCRFNucnBrMndIT0ZCdlRjY1MxTFNhV09TWjdNM3ljdHQ0WFl0UDFHWGZqbzZNeXJpVGFMbzhNbGhUOW14T1BDM0JMQ1MxR2FzbHVySGRNbWp6Z3c3WE9QWmlFWG9GdG5VWWVmSWI1eTV5QWlpNnZLODYzSFVqRDh6RlQ5cVVGaEhpUC94OUwyaW8wZ0tXRHY4RHJVQmRaTkw2Ritma3ZnckVoTGxLQzFwc2tvbHd3MEYzdHltM0hSdFRlK1pVUT09IiwiaXYiOiIwaXN6WGVKM0p6K0xlczhQY0VKbGFBPT0iLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNzcwMDQ1OTIyLCJleHAiOjE3NzAxMzIzMjJ9.CeoJ_LnbW0UdstmaAO1U6Z3HTgNCGIMByRUzWpKy5BQ',
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
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ0ZnoyYldMY1Q4NGZUQm9aU0ZkbkVJSFVqUW03eWRDZFR1dDk4K3Vkd0p4OXRTY1dFZEY4VGExajQ0c0g3RWxyYWFrdWtHYnRFVzJIeUt4cEk5NnJ6QVpHZDVVYU8vRU9HdjlUVXB5VEFKTTc3S3dXMkdQUHVVN0lNbm53K1VCK3YxdDJ0aFYrWU5RTUtsVU1OR2ZuWnUvUEpJdlpOMFBLbCttc0FZMThuUks2TFlRUHpGTjUxVEk4L1JhRndZOWdnckZtWExZZWZSeTk3TXpBQStwekE4VkYwU0szamd0ZGpKUFRNTFl3ZGUrQXEyNW5EL0hSaXZqSHNLaGFvbjZmZG5FcnRIdisvQ21CQXR6TGRPS2RCZmUrMm5UWnpBbjhXMStvWEt5YTEwN3ZvKzFNZjI5ZElvV2dzSlF1bDcxOXRDdnoyN0hCUzQxOCt2TW9jcEZ2bmx6S3A5Y05JdkExdEdIMVlxdXlKOTJlQlJqZ1MvMGIyanc2a0k2dGo2Q3UwaUpCNU5uUVgvNnVpc3QyemZ5dGdRT2crYmZlTDY0VW5ZTFRITlNDQitRbFhsTVY3bWNNYzVHT2RKSGIwbUFaeElxSTdKdkxtck1lZkpGRDVkRk5CczlCRFNucnBrMndIT0ZCdlRjY1MxTFNhV09TWjdNM3ljdHQ0WFl0UDFHWGZqbzZNeXJpVGFMbzhNbGhUOW14T1BDM0JMQ1MxR2FzbHVySGRNbWp6Z3c3WE9QWmlFWG9GdG5VWWVmSWI1eTV5QWlpNnZLODYzSFVqRDh6RlQ5cVVGaEhpUC94OUwyaW8wZ0tXRHY4RHJVQmRaTkw2Ritma3ZnckVoTGxLQzFwc2tvbHd3MEYzdHltM0hSdFRlK1pVUT09IiwiaXYiOiIwaXN6WGVKM0p6K0xlczhQY0VKbGFBPT0iLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNzcwMDQ1OTIyLCJleHAiOjE3NzAxMzIzMjJ9.CeoJ_LnbW0UdstmaAO1U6Z3HTgNCGIMByRUzWpKy5BQ',
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
