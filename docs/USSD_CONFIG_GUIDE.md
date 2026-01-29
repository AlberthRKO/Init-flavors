## Configuración USSD - Estructura Escalable

Esta es la documentación sobre cómo agregar nuevos operadores y comandos USSD al sistema.

### 📁 Archivos Principales

1. **`lib/app/domain/models/ussd/ussd_command.dart`**
   - Define los modelos `UssdCommand`, `UssdCategory` y `OperadorUssdConfig`
   - Estos son los tipos de datos que estructuran los comandos USSD

2. **`lib/app/data/resources/ussd_commands_database.dart`**
   - Contiene la base de datos con la configuración de cada operador
   - Aquí es donde se definen los comandos USSD por operador

3. **`lib/app/domain/services/ussd_command_service.dart`**
   - Servicio que proporciona métodos para acceder a los comandos
   - Maneja validación y errores si un operador no está configurado

### 🔧 Cómo Agregar un Nuevo Operador

**Paso 1:** Abre `ussd_commands_database.dart`

**Paso 2:** Define la configuración del nuevo operador al final del archivo:

```dart
// Configuración USSD para NUEVO_OPERADOR
static const OperadorUssdConfig _nuevoOperadorConfig = OperadorUssdConfig(
  operador: 'nuevooperador',
  categories: {
    'saldo': UssdCategory(
      name: 'Saldo',
      commands: [
        UssdCommand(
          title: 'Consulta de Saldo',
          code: '*XXX#',
          description: 'Ver saldo disponible',
        ),
        UssdCommand(
          title: 'Consulta de Saldo Detallado',
          code: '*XXX*1#',
          description: 'Ver saldo con detalles',
        ),
      ],
    ),
    'paquetes': UssdCategory(
      name: 'Paquetes',
      commands: [
        UssdCommand(
          title: 'Paquetes por Bs 2',
          code: '*XXX*1*1*1*1#',
          description: 'Comprar paquete de Bs 2',
        ),
        // ... más paquetes
      ],
    ),
  },
);
```

**Paso 3:** Agrégalo al mapa `_database`:

```dart
static const Map<String, OperadorUssdConfig> _database = {
  'entel': _entelConfig,
  'tigo': _tigoConfig,
  'viva': _vivaConfig,
  'nuevooperador': _nuevoOperadorConfig,  // ← AGREGAR AQUÍ
};
```

**Paso 4:** En `home.dart`, actualiza el autodetector de operadores en `_checkAndShowOperadoraModal()`:

```dart
if (carrierName.contains('nuevooperador') || displayName.contains('nuevooperador')) {
  operadoraName = 'nuevooperador';
}
```

### 📋 Estructura de Datos

```dart
UssdCommand {
  title: "Nombre del comando",
  code: "*XXX#",
  description: "Descripción opcional"
}

UssdCategory {
  name: "Nombre de la categoría",
  commands: [UssdCommand, ...]
}

OperadorUssdConfig {
  operador: "nombre_operador",
  categories: {
    'saldo': UssdCategory,
    'paquetes': UssdCategory,
    ...
  }
}
```

### 🎯 Cómo Usar el Servicio

```dart
// Obtener configuración completa de un operador
final config = UssdCommandService.getOperadorConfig('entel');

// Obtener comandos de una categoría
final commands = UssdCommandService.getCategoryCommands('entel', 'paquetes');

// Obtener una categoría específica
final category = UssdCommandService.getCategory('entel', 'saldo');

// Obtener todos los comandos de un operador
final allCommands = UssdCommandService.getAllCommands('entel');

// Verificar si un operador está soportado
bool isSupported = UssdCommandService.isOperadorSoportado('entel');

// Obtener lista de operadores disponibles
List<String> operators = UssdCommandService.getOperadoresDisponibles();
```

### ⚠️ Manejo de Errores

Si intentas acceder a un operador no configurado, se lanza una `UssdOperadorNoConfiguradoException`:

```dart
try {
  final config = UssdCommandService.getOperadorConfig('desconocido');
} catch (e) {
  print(e); // Error: Operador "desconocido" no tiene comandos USSD configurados
}
```

### 🔄 Flujo de Datos

```
CustomAppbar
    ↓
User taps "Comprar Paquetes"
    ↓
_showPackagesDropdown()
    ↓
UssdCommandService.getCategoryCommands(operador, 'paquetes')
    ↓
UssdCommandsDatabase.getConfig(operador)
    ↓
Build UI dynámicamente con los comandos
    ↓
User selecciona opción
    ↓
_comprarPaqueteDirecto(ussdCode) en home.dart
    ↓
Ejecutar USSD
```

### ✨ Ventajas de Esta Arquitectura

✅ **Escalable:** Agregar nuevos operadores es trivial
✅ **Mantenible:** Los comandos están centralizados en un solo lugar
✅ **Type-safe:** Usa modelos en lugar de strings hardcodeados
✅ **Validación:** Verifica automáticamente si un operador está soportado
✅ **Flexible:** Fácil agregar nuevas categorías (no solo "saldo" y "paquetes")
✅ **Documentado:** Cada comando tiene descripción

### 🚀 Próximas Extensiones

Para futuras extensiones, puedes agregar:

```dart
class UssdCommand {
  final String title;
  final String code;
  final String description;
  final bool requiresUserInput;      // ← Para comandos interactivos
  final List<String> supportedDevices; // ← Por tipo de dispositivo
  final DateTime addedDate;           // ← Control de versión
}
```
