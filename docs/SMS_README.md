# SMS Service - Solución de Problemas

## Problemas Resueltos

1. **Acentos** (á, é, í, ó, ú, ñ): Fuerzan codificación UCS-2 que algunos operadores rechazan
2. **Mensajes largos**: Superan límite de 160 caracteres (GSM-7) o 70 caracteres (UCS-2)
3. **Filtros anti-spam TIGO**: Bloquea combinación "Codigo" + "Verificacion"

## Soluciones Implementadas

### ✅ 1. Normalización de Acentos

Convierte automáticamente caracteres con acento a caracteres GSM-7 básicos.

### ✅ 2. División Automática de Mensajes Largos

Divide mensajes en partes apropiadas cuando exceden el límite.

### ✅ 3. Reemplazo Anti-Spam (NUEVO)

**"Verificación" se reemplaza automáticamente por "SMS"** para evitar filtros de TIGO Bolivia.

## Uso

### Uso por defecto (Recomendado)

```dart
await SmsService.sendSms(
  phoneNumber: "77123456",
  message: "Código de Verificación para el módulo MP: 123456",
  simSlot: 0,
);
// Resultado enviado: "Codigo de SMS para el modulo MP: 123456"
```

### Control manual

```dart
await SmsService.sendSms(
  phoneNumber: "77123456",
  message: "Mensaje largo con áéíóú...",
  simSlot: 0,
  normalizeText: true,   // true = normaliza y evita filtros (por defecto)
  autoSplit: true,      // true = divide mensajes largos (por defecto)
);
```

## Transformaciones Aplicadas

### Acentos

| Original    | Normalizado |
| ----------- | ----------- |
| `á é í ó ú` | `a e i o u` |
| `Á É Í Ó Ú` | `A E I O U` |
| `ñ Ñ`       | `n N`       |
| `ü Ü`       | `u U`       |
| `" " ' '`   | `" " ' '`   |
| `– —`       | `-`         |

### Anti-Spam (TIGO Bolivia)

| Original                                         | Procesado                               |
| ------------------------------------------------ | --------------------------------------- |
| `Código de Verificación`                         | `Codigo de SMS`                         |
| `código de verificación`                         | `codigo de SMS`                         |
| `Verificación para login`                        | `SMS para login`                        |
| `Código de Verificación para el módulo MP: 1234` | `Codigo de SMS para el modulo MP: 1234` |

### Ejemplo Completo

```
Original:    "Código de Verificación para el módulo MP: 123456"
Paso 1:      "Codigo de SMS para el módulo MP: 123456"  (Verificación → SMS)
Paso 2:      "Codigo de SMS para el modulo MP: 123456"  (Acentos normalizados)
Enviado:     "Codigo de SMS para el modulo MP: 123456"  ✅
```

## Funciones Útiles

### Analizar mensaje antes de enviar

```dart
final analysis = SmsService.analyzeMessage("Tu mensaje");
print(analysis);
// {
//   'encoding': 'GSM-7',
//   'length': 45,
//   'parts': 1,
//   'maxLength': 160,
//   ...
// }
```

### Normalizar manualmente (incluye reemplazo anti-spam)

```dart
final normalized = SmsService.normalizeMessage("Código de Verificación: 123");
print(normalized); // "Codigo de SMS: 123"
```

### Dividir mensaje largo

```dart
final parts = SmsService.splitMessage("mensaje muy largo...");
print(parts.length); // Número de partes
```

### Análisis detallado (detecta palabras bloqueadas)

```dart
final detailed = SmsService.detailedAnalysis("Codigo de verificacion");
print(detailed['suspiciousWords']); // ['codigo', 'verificacion']
```

## Recomendaciones

✅ **Usar normalización** (ya está habilitada por defecto)  
✅ **El sistema reemplaza "Verificación" automáticamente**  
✅ **Evitar emojis** (😊 👍 🎉)  
✅ **Limitar a ~300 caracteres** para evitar muchas partes  
❌ **No usar símbolos especiales** (™ © ® • ★)

## Logs del Sistema

Ahora verás en consola:

```
🔄 "Verificación" reemplazado por "SMS" (evita filtro anti-spam)
⚠️ Mensaje normalizado (acentos removidos)
   Original: "Código de Verificación para el módulo MP: 362566"
   Normalizado: "Codigo de SMS para el modulo MP: 362566"
📱 Enviando SMS a: +59163354864
💬 Mensaje: Codigo de SMS para el modulo MP: 362566
📊 Análisis: GSM-7, 46 caracteres, 1 parte(s)
📡 Usando SIM slot: 0
✅ SMS enviado exitosamente a +59163354864
```

## Debugging

Si el mensaje no llega, revisa los logs en consola:

```
📊 Análisis: GSM-7, 45 caracteres, 1 parte(s)
📱 Enviando SMS a: 77123456
✅ SMS enviado exitosamente
```

Si ves "enviado exitosamente" pero no llega:

1. Verifica el **SIM slot** (probar con 0 y 1)
2. Verifica **permisos** (SMS, Teléfono)
3. Verifica **saldo** del operador
4. Prueba con mensaje simple: `"test"`
