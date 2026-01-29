import 'package:gw_sms/app/domain/models/ussd/ussd_command.dart';

/// Base de datos de configuración USSD para cada operador
/// Contiene todos los comandos disponibles organizados por categoría
class UssdCommandsDatabase {
  static const Map<String, OperadorUssdConfig> _database = {
    'entel': _entelConfig,
    'tigo': _tigoConfig,
    'viva': _vivaConfig,
  };

  /// Configuración USSD para ENTEL
  static const OperadorUssdConfig _entelConfig = OperadorUssdConfig(
    operador: 'entel',
    categories: {
      'saldo': UssdCategory(
        name: 'Saldo',
        commands: [
          UssdCommand(
            title: 'Consulta de Saldo',
            code: '*105#',
            description: 'Ver saldo disponible',
          ),
          UssdCommand(
            title: 'Consulta de Saldo Detallado',
            code: '*105*1#',
            description: 'Ver saldo con detalles',
          ),
        ],
      ),
      'paquetes': UssdCategory(
        name: 'Paquetes',
        commands: [
          UssdCommand(
            title: 'Paquetes por Bs 2',
            code: '*10*1*1*1*1#',
            description: 'Comprar paquete de Bs 2',
          ),
          UssdCommand(
            title: 'Paquetes por Bs 4',
            code: '*10*1*1*2*1#',
            description: 'Comprar paquete de Bs 4',
          ),
          UssdCommand(
            title: 'Paquetes por Bs 10',
            code: '*10*1*1*3*1#',
            description: 'Comprar paquete de Bs 10',
          ),
        ],
      ),
    },
  );

  /// Configuración USSD para TIGO
  static const OperadorUssdConfig _tigoConfig = OperadorUssdConfig(
    operador: 'tigo',
    categories: {
      'saldo': UssdCategory(
        name: 'Saldo',
        commands: [
          UssdCommand(
            title: 'Consulta de Saldo',
            code: '*105#',
            description: 'Ver saldo disponible',
          ),
          UssdCommand(
            title: 'Consulta de Saldo Detallado',
            code: '*105*1#',
            description: 'Ver saldo con detalles',
          ),
        ],
      ),
      'paquetes': UssdCategory(
        name: 'Paquetes',
        commands: [
          UssdCommand(
            title: 'Paquetes por Bs 2',
            code: '*555*1*1*1*1#',
            description: 'Comprar paquete de Bs 2',
          ),
          UssdCommand(
            title: 'Paquetes por Bs 4',
            code: '*555*1*1*2*1#',
            description: 'Comprar paquete de Bs 4',
          ),
          UssdCommand(
            title: 'Paquetes por Bs 10',
            code: '*555*1*1*3*1#',
            description: 'Comprar paquete de Bs 10',
          ),
        ],
      ),
    },
  );

  /// Configuración USSD para VIVA
  static const OperadorUssdConfig _vivaConfig = OperadorUssdConfig(
    operador: 'viva',
    categories: {
      'saldo': UssdCategory(
        name: 'Saldo',
        commands: [
          UssdCommand(
            title: 'Consulta de Saldo',
            code: '*555#',
            description: 'Ver saldo disponible',
          ),
          UssdCommand(
            title: 'Consulta de Saldo Detallado',
            code: '*555*1#',
            description: 'Ver saldo con detalles',
          ),
        ],
      ),
      'paquetes': UssdCategory(
        name: 'Paquetes',
        commands: [
          UssdCommand(
            title: 'Paquetes por Bs 2',
            code: '*121*1*1*1*1#',
            description: 'Comprar paquete de Bs 2',
          ),
          UssdCommand(
            title: 'Paquetes por Bs 4',
            code: '*121*1*1*2*1#',
            description: 'Comprar paquete de Bs 4',
          ),
          UssdCommand(
            title: 'Paquetes por Bs 10',
            code: '*121*1*1*3*1#',
            description: 'Comprar paquete de Bs 10',
          ),
        ],
      ),
    },
  );

  /// Obtiene la configuración de un operador
  /// Retorna null si el operador no está configurado
  static OperadorUssdConfig? getConfig(String operador) {
    return _database[operador.toLowerCase()];
  }

  /// Obtiene todos los operadores disponibles
  static List<String> getAvailableOperators() {
    return _database.keys.toList();
  }

  /// Verifica si un operador está configurado
  static bool isOperadorConfigured(String operador) {
    return _database.containsKey(operador.toLowerCase());
  }

  /// Obtiene todos los comandos de una categoría para un operador
  static List<UssdCommand>? getCommandsForCategory(
    String operador,
    String category,
  ) {
    final config = getConfig(operador);
    return config?.getCommands(category);
  }

  /// Obtiene una categoría específica para un operador
  static UssdCategory? getCategory(String operador, String category) {
    final config = getConfig(operador);
    return config?.getCategory(category);
  }
}
