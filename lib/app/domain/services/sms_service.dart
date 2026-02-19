import 'package:sms_sender/sms_sender.dart';

class SmsService {
  // Caracteres del alfabeto GSM-7 básico
  static const String _gsm7Characters =
      "@£\$¥èéùìòÇ\nØø\rÅåΔ_ΦΓΛΩΠΨΣΘΞÆæßÉ !\"#¤%&'()*+,-./0123456789:;<=>?"
      '¡ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÑÜ§¿abcdefghijklmnopqrstuvwxyzäöñüà';

  // Caracteres extendidos GSM-7 (cuentan como 2 caracteres)
  static const String _gsm7Extended = r'^{}\[~]|€';

  /// Límites de caracteres según codificación
  static const int _maxLengthGsm7 = 160;
  static const int _maxLengthUcs2 = 70;
  static const int _maxLengthGsm7Multipart = 153; // 160 - 7 (header)
  static const int _maxLengthUcs2Multipart = 67; // 70 - 3 (header)

  /// Verifica si un mensaje usa solo caracteres GSM-7
  static bool _isGsm7(String message) {
    for (final char in message.runes) {
      final charString = String.fromCharCode(char);
      if (!_gsm7Characters.contains(charString) &&
          !_gsm7Extended.contains(charString)) {
        return false;
      }
    }
    return true;
  }

  /// Calcula la longitud efectiva del mensaje en GSM-7
  /// (caracteres extendidos cuentan doble)
  static int _getGsm7Length(String message) {
    var length = 0;
    for (final char in message.runes) {
      final charString = String.fromCharCode(char);
      if (_gsm7Extended.contains(charString)) {
        length += 2; // Caracteres extendidos cuentan doble
      } else {
        length += 1;
      }
    }
    return length;
  }

  /// Normaliza el mensaje removiendo o reemplazando caracteres problemáticos
  static String normalizeMessage(String message) {
    var normalized = message;

    // IMPORTANTE: Reemplazar "Verificación" por "SMS" para evitar filtros anti-spam
    // TIGO bloquea la combinación "Codigo" + "Verificacion"
    normalized = normalized
        .replaceAll(RegExp('Verificaci[óo]n', caseSensitive: false), 'SMS')
        .replaceAll(RegExp('verificaci[óo]n', caseSensitive: false), 'SMS');

    // Mapa de reemplazo de caracteres con acento a sin acento
    const replacements = {
      'á': 'a',
      'é': 'e',
      'í': 'i',
      'ó': 'o',
      'ú': 'u',
      'Á': 'A',
      'É': 'E',
      'Í': 'I',
      'Ó': 'O',
      'Ú': 'U',
      'ñ': 'n',
      'Ñ': 'N',
      'ü': 'u',
      'Ü': 'U',
      '–': '-',
      '—': '-',
      '…': '...',
    };

    replacements.forEach((key, value) {
      normalized = normalized.replaceAll(key, value);
    });

    // Reemplazar comillas especiales
    normalized = normalized
        .replaceAll('''
, "'")
        .replaceAll(''', "'")
        .replaceAll('"', '"')
        .replaceAll('"', '"');

    return normalized;
  }

  /// Analiza el mensaje en detalle carácter por carácter
  static Map<String, dynamic> detailedAnalysis(String message) {
    final problematicChars = <String>[];
    final problematicWords = [
      'verificacion',
      'codigo',
      'password',
      'contraseña',
      'pin',
      'otp',
      'token',
    ];

    // Detectar caracteres no GSM-7
    for (final char in message.runes) {
      final charString = String.fromCharCode(char);
      if (!_gsm7Characters.contains(charString) &&
          !_gsm7Extended.contains(charString)) {
        if (!problematicChars.contains(charString)) {
          problematicChars.add(charString);
        }
      }
    }

    // Detectar palabras sospechosas (filtros anti-spam)
    final messageLower = message.toLowerCase();
    final detectedWords = <String>[];
    for (final word in problematicWords) {
      if (messageLower.contains(word)) {
        detectedWords.add(word);
      }
    }

    return {
      'problematicChars': problematicChars,
      'suspiciousWords': detectedWords,
      'hasSuspiciousWords': detectedWords.isNotEmpty,
      'recommendation': detectedWords.isEmpty
          ? 'OK - debería funcionar'
          : 'ADVERTENCIA: Palabras bloqueadas por operador',
    };
  }

  /// Sugiere una versión alternativa del mensaje que evita filtros
  static String suggestAlternative(String message) {
    var alternative = normalizeMessage(message);

    // Simplificar mensajes largos
    alternative = alternative
        .replaceAll('Codigo de Verificacion para el modulo', 'Codigo')
        .replaceAll('codigo de verificacion para el modulo', 'codigo')
        .replaceAll('para el modulo', '')
        .replaceAll('de verificacion', '')
        .replaceAll('Verificacion', '');

    // Limpiar espacios múltiples
    alternative = alternative.replaceAll(RegExp(r'\s+'), ' ').trim();

    return alternative;
  }

  /// Valida y analiza el mensaje antes de enviar
  static Map<String, dynamic> analyzeMessage(String message) {
    final isGsm7 = _isGsm7(message);
    final encoding = isGsm7 ? 'GSM-7' : 'UCS-2';
    final effectiveLength = isGsm7 ? _getGsm7Length(message) : message.length;
    final maxLength = isGsm7 ? _maxLengthGsm7 : _maxLengthUcs2;
    final maxLengthMultipart = isGsm7
        ? _maxLengthGsm7Multipart
        : _maxLengthUcs2Multipart;

    final isMultipart = effectiveLength > maxLength;
    final parts = isMultipart
        ? (effectiveLength / maxLengthMultipart).ceil()
        : 1;

    return {
      'encoding': encoding,
      'isGsm7': isGsm7,
      'length': effectiveLength,
      'maxLength': maxLength,
      'isMultipart': isMultipart,
      'parts': parts,
      'canSend': true, // Algunos operadores limitan a 5 partes
      'warning': parts > 3 ? 'Mensaje muy largo ($parts partes)' : null,
    };
  }

  /// Divide un mensaje largo en partes apropiadas
  static List<String> splitMessage(String message) {
    final analysis = analyzeMessage(message);
    final maxLength = analysis['isMultipart'] as bool
        ? (analysis['isGsm7'] as bool
              ? _maxLengthGsm7Multipart
              : _maxLengthUcs2Multipart)
        : (analysis['isGsm7'] as bool ? _maxLengthGsm7 : _maxLengthUcs2);

    if (!(analysis['isMultipart'] as bool)) {
      return [message];
    }

    final parts = <String>[];
    var remaining = message;

    while (remaining.isNotEmpty) {
      if (remaining.length <= maxLength) {
        parts.add(remaining);
        break;
      }

      // Intentar dividir en un espacio cercano al límite
      var splitIndex = maxLength;
      final nearbySpace = remaining.lastIndexOf(' ', maxLength);
      if (nearbySpace > maxLength * 0.8) {
        splitIndex = nearbySpace + 1;
      }

      parts.add(remaining.substring(0, splitIndex).trim());
      remaining = remaining.substring(splitIndex).trim();
    }

    return parts;
  }

  /// Envía un SMS a un número de teléfono específico
  /// [phoneNumber]: Número a donde enviar el SMS
  /// [message]: Contenido del mensaje
  /// [simSlot]: Índice del slot de SIM (0 o 1, por defecto 0)
  /// [normalizeText]: Si es true, normaliza acentos y caracteres especiales
  /// [autoSplit]: Si es true, divide mensajes largos automáticamente
  static Future<bool> sendSms({
    required String phoneNumber,
    required String message,
    int simSlot = 0,
    bool normalizeText = true,
    bool autoSplit = true,
  }) async {
    try {
      // Analizar el mensaje
      var processedMessage = message;

      // Normalizar si está habilitado
      if (normalizeText) {
        final originalMessage = processedMessage;
        processedMessage = normalizeMessage(processedMessage);

        if (processedMessage != message) {
          // Detectar si se reemplazó "Verificación"
          if (originalMessage.toLowerCase().contains('verificaci') &&
              processedMessage.toLowerCase().contains('sms')) {
            print(
              '🔄 "Verificación" reemplazado por "SMS" (evita filtro anti-spam)',
            );
          }
          print('⚠️ Mensaje normalizado (acentos removidos)');
          if (originalMessage != processedMessage) {
            print('   Original: "$message"');
            print('   Normalizado: "$processedMessage"');
          }
        }
      }

      // Análisis detallado para detectar problemas
      final detailed = detailedAnalysis(processedMessage);
      if (detailed['hasSuspiciousWords'] as bool) {
        print(
          '⚠️ ADVERTENCIA: Mensaje contiene palabras que pueden ser bloqueadas por el operador',
        );
        print('   Palabras detectadas: ${detailed['suspiciousWords']}');
        print('   Recomendación: ${detailed['recommendation']}');

        final alternative = suggestAlternative(message);
        print('💡 Alternativa sugerida: "$alternative"');
      }

      final analysis = analyzeMessage(processedMessage);

      print('📱 Enviando SMS a: $phoneNumber');
      print('💬 Mensaje: $processedMessage');
      print(
        '📊 Análisis: ${analysis['encoding']}, ${analysis['length']} caracteres, ${analysis['parts']} parte(s)',
      );
      print('📡 Usando SIM slot: $simSlot');

      // Advertir si es multipart
      if (analysis['isMultipart'] as bool) {
        print('⚠️ Mensaje largo detectado: ${analysis['parts']} partes');

        if (!autoSplit) {
          print('❌ Mensaje excede límite y autoSplit está deshabilitado');
          return false;
        }

        // Dividir y enviar cada parte
        final parts = splitMessage(processedMessage);
        print('📨 Enviando ${parts.length} partes...');

        for (var i = 0; i < parts.length; i++) {
          print('📤 Enviando parte ${i + 1}/${parts.length}');

          await SmsSender.sendSms(
            phoneNumber: phoneNumber,
            message: parts[i],
            simSlot: simSlot,
          );

          // Pequeña pausa entre mensajes (algunos operadores lo requieren)
          if (i < parts.length - 1) {
            await Future<void>.delayed(const Duration(milliseconds: 500));
          }
        }

        print('✅ Todas las partes enviadas exitosamente a $phoneNumber');
        return true;
      }

      // Mensaje simple (una sola parte)
      await SmsSender.sendSms(
        phoneNumber: phoneNumber,
        message: processedMessage,
        simSlot: simSlot,
      );

      print('✅ SMS enviado exitosamente a $phoneNumber');
      return true;
    } catch (e) {
      print('❌ Error al enviar SMS: $e');
      return false;
    }
  }

  /// Versión que preserva acentos (puede fallar con algunos operadores)
  static Future<bool> sendSmsWithAccents({
    required String phoneNumber,
    required String message,
    int simSlot = 0,
  }) async {
    return sendSms(
      phoneNumber: phoneNumber,
      message: message,
      simSlot: simSlot,
      normalizeText: false,
    );
  }
}
