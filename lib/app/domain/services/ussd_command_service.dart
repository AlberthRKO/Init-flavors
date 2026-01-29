import 'package:gw_sms/app/data/resources/ussd_commands_database.dart';
import 'package:gw_sms/app/domain/models/ussd/ussd_command.dart';

/// Servicio para obtener comandos USSD de forma dinámica
/// Maneja la lógica de validación y errores si un operador no está configurado
class UssdCommandService {
  /// Obtiene la configuración completa de un operador
  /// Lanza excepción si el operador no está configurado
  static OperadorUssdConfig getOperadorConfig(String operador) {
    final config = UssdCommandsDatabase.getConfig(operador);
    if (config == null) {
      throw UssdOperadorNoConfiguradoException(operador);
    }
    return config;
  }

  /// Obtiene los comandos de una categoría para un operador
  /// Retorna lista vacía si la categoría no existe
  static List<UssdCommand> getCategoryCommands(
    String operador,
    String category,
  ) {
    try {
      final config = getOperadorConfig(operador);
      return config.getCommands(category) ?? [];
    } on UssdOperadorNoConfiguradoException {
      rethrow;
    }
  }

  /// Obtiene una categoría específica
  /// Retorna null si no existe
  static UssdCategory? getCategory(String operador, String category) {
    try {
      return UssdCommandsDatabase.getCategory(operador, category);
    } catch (e) {
      return null;
    }
  }

  /// Obtiene todos los comandos disponibles para un operador
  static List<UssdCommand> getAllCommands(String operador) {
    try {
      final config = getOperadorConfig(operador);
      final allCommands = <UssdCommand>[];
      for (final category in config.categories.values) {
        allCommands.addAll(category.commands);
      }
      return allCommands;
    } on UssdOperadorNoConfiguradoException {
      rethrow;
    }
  }

  /// Obtiene una lista de todas las categorías para un operador
  static List<UssdCategory> getAllCategories(String operador) {
    try {
      final config = getOperadorConfig(operador);
      return config.categories.values.toList();
    } on UssdOperadorNoConfiguradoException {
      rethrow;
    }
  }

  /// Verifica si un operador está soportado
  static bool isOperadorSoportado(String operador) {
    return UssdCommandsDatabase.isOperadorConfigured(operador);
  }

  /// Obtiene lista de todos los operadores disponibles
  static List<String> getOperadoresDisponibles() {
    return UssdCommandsDatabase.getAvailableOperators();
  }
}

/// Excepción personalizada cuando un operador no está configurado
class UssdOperadorNoConfiguradoException implements Exception {
  UssdOperadorNoConfiguradoException(this.operador);

  final String operador;

  @override
  String toString() =>
      'Operador "$operador" no tiene comandos USSD configurados. '
      'Operadores disponibles: ${UssdCommandsDatabase.getAvailableOperators().join(", ")}';
}
