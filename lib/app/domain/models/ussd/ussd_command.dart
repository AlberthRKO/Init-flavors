/// Representa un comando USSD individual
class UssdCommand {
  const UssdCommand({
    required this.title,
    required this.code,
    this.description = '',
  });

  /// Título o nombre del comando (ej: "Consulta de Saldo")
  final String title;

  /// Código USSD a ejecutar (ej: "*105#")
  final String code;

  /// Descripción opcional del comando
  final String description;

  @override
  String toString() => 'UssdCommand($title, $code)';
}

/// Representa una categoría de comandos (ej: "Saldo", "Paquetes")
class UssdCategory {
  const UssdCategory({
    required this.name,
    required this.commands,
  });

  /// Nombre de la categoría (ej: "Saldo", "Paquetes")
  final String name;

  /// Lista de comandos en esta categoría
  final List<UssdCommand> commands;

  @override
  String toString() => 'UssdCategory($name, ${commands.length} comandos)';
}

/// Configuración USSD para un operador específico
class OperadorUssdConfig {
  const OperadorUssdConfig({
    required this.operador,
    required this.categories,
  });

  /// Nombre del operador (ej: "entel", "tigo", "viva")
  final String operador;

  /// Mapa de categorías: 'saldo' => UssdCategory, 'paquetes' => UssdCategory
  final Map<String, UssdCategory> categories;

  /// Obtiene una categoría específica por nombre
  UssdCategory? getCategory(String name) => categories[name.toLowerCase()];

  /// Obtiene todos los comandos de una categoría
  List<UssdCommand>? getCommands(String categoryName) {
    return getCategory(categoryName)?.commands;
  }

  @override
  String toString() =>
      'OperadorUssdConfig($operador, ${categories.length} categorías)';
}
