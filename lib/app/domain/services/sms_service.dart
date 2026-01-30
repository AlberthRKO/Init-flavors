import 'package:sms_sender/sms_sender.dart';

class SmsService {
  /// Envía un SMS a un número de teléfono específico
  /// [phoneNumber]: Número a donde enviar el SMS
  /// [message]: Contenido del mensaje
  /// [simSlot]: Índice del slot de SIM (0 o 1, por defecto 0)
  static Future<bool> sendSms({
    required String phoneNumber,
    required String message,
    int simSlot = 0,
  }) async {
    try {
      print('📱 Enviando SMS a: $phoneNumber');
      print('💬 Mensaje: $message');
      print('📡 Usando SIM slot: $simSlot');

      await SmsSender.sendSms(
        phoneNumber: phoneNumber,
        message: message,
        simSlot: simSlot,
      );

      print('✅ SMS enviado exitosamente a $phoneNumber');
      return true;
    } catch (e) {
      print('❌ Error al enviar SMS: $e');
      return false;
    }
  }
}
