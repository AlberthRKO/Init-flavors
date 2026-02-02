# Servicio de SMS en Segundo Plano

## 📋 Descripción

Este módulo implementa un servicio en segundo plano para la aplicación GW SMS que permite:

- 🔄 Recibir mensajes del WebSocket continuamente, incluso cuando la app está en segundo plano
- 📱 Enviar SMS automáticamente cuando llegan mensajes del servidor
- 🎯 Soporte para múltiples tarjetas SIM
- 🔔 Notificaciones del estado del servicio y los SMS enviados

## 🏗️ Arquitectura

### Componentes principales

1. **BackgroundSmsService** (`background_sms_service.dart`)
   - Servicio principal que se ejecuta en segundo plano
   - Mantiene conexión WebSocket activa
   - Procesa mensajes entrantes y envía SMS automáticamente

2. **BackgroundServiceHelper** (`background_service_helper.dart`)
   - Clase helper para inicializar y controlar el servicio
   - Gestiona el ciclo de vida del servicio
   - Maneja notificaciones y actualizaciones de estado

3. **Integración en HomePage** (`home.dart`)
   - UI para controlar el servicio (iniciar/detener)
   - Banner indicador del estado del servicio
   - Sincronización de la operadora seleccionada con el servicio

## 🚀 Funcionamiento

### Flujo de Trabajo

```
1. Usuario inicia la app
   ↓
2. Se inicializa el servicio de background
   ↓
3. Usuario selecciona operadora (Entel/Tigo/Viva)
   ↓
4. Usuario inicia el servicio desde el banner
   ↓
5. Servicio conecta al WebSocket en segundo plano
   ↓
6. Cuando llega un mensaje del servidor:
   - Se parsea el mensaje
   - Se extrae el número del destinatario
   - Se envía SMS automáticamente usando la SIM correcta
   - Se muestra notificación del resultado
```

### Detección automática de SIM

El servicio detecta automáticamente qué slot de SIM usar basándose en la operadora seleccionada:

```dart
// Ejemplo: Si el usuario selecciona "Entel"
// El servicio busca en las SIMs disponibles
// y usa el slot que corresponda a Entel
```

## 📱 Permisos Requeridos

En `AndroidManifest.xml`:

```xml
<!-- Servicio en segundo plano -->
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_DATA_SYNC" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS" />

<!-- SMS -->
<uses-permission android:name="android.permission.SEND_SMS" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />

<!-- Internet para WebSocket -->
<uses-permission android:name="android.permission.INTERNET" />
```

## 🎮 Control del Servicio

### Desde la Interfaz de Usuario

El usuario puede controlar el servicio mediante un banner en la parte superior de la pantalla principal:

- **Estado Activo** (fondo verde):
  - 🟢 "Servicio activo - SMS automáticos habilitados"
  - Botón "Detener" para pausar el servicio

- **Estado Detenido** (fondo naranja):
  - 🟠 "Servicio detenido - SMS solo en primer plano"
  - Botón "Iniciar" para activar el servicio

### Programáticamente

```dart
// Inicializar
await BackgroundServiceHelper().initializeService();

// Iniciar
await BackgroundServiceHelper().startService();

// Detener
await BackgroundServiceHelper().stopService();

// Actualizar operadora
await BackgroundServiceHelper().updateOperadora('entel', 0);
```

## 🔔 Notificaciones

El servicio muestra notificaciones para:

1. **Estado del servicio**
   - Cuando el servicio se inicia
   - Cuando se conecta/desconecta del WebSocket

2. **Envío de SMS**
   - ✅ "SMS Enviado" - Cuando se envía exitosamente
   - ❌ "Error al Enviar SMS" - Cuando falla el envío

## 📊 Logging y Debug

El servicio genera logs detallados:

```
🚀 Iniciando servicio de SMS en background...
✅ WebSocket conectado en background
📨 Mensaje recibido en background: {...}
📱 Preparando envío de SMS...
   Destinatario CI: 12345678
   Número: +59163354864
   Mensaje: Hola mundo
   SIM slot: 0
✅ SMS enviado exitosamente desde background
💓 Servicio de background activo...
```

## ⚙️ Configuración

### Número de Teléfono Estático

Actualmente configurado en `background_sms_service.dart`:

```dart
const phoneNumber = '+59163354864';
```

### Reconexión Automática

El servicio intenta reconectar automáticamente al WebSocket cada 10 segundos si se pierde la conexión.

### Keep Alive

Un timer mantiene el servicio activo enviando actualizaciones cada 5 minutos.

## 🛠️ Mantenimiento

### Actualizar Token de WebSocket

El token está hardcodeado en el servicio. Para actualizarlo:

1. Ir a `background_sms_service.dart`
2. Buscar la constante `token`
3. Reemplazar con el nuevo token

### Cambiar URL del WebSocket

Modificar en `background_sms_service.dart`:

```dart
const url = 'https://ms-websocket-ws.dev.mp.gob.bo/chat?usuarioId=790&aplicacion=roma';
```

## 📝 Notas Importantes

1. **El servicio NO se detiene** cuando la app se cierra (por diseño)
2. **Requiere batería**: Solicitar al usuario desactivar optimización de batería
3. **Android 12+**: Requiere declarar el tipo de servicio foreground (`dataSync`)
4. **Múltiples SIMs**: Probado con dispositivos dual-SIM

## 🐛 Troubleshooting

### El servicio no inicia

1. Verificar permisos en AndroidManifest.xml
2. Revisar que flutter_background_service esté correctamente instalado
3. Verificar logs: `adb logcat | grep BackgroundSms`

### SMS no se envían

1. Verificar permisos de SMS
2. Comprobar que la operadora esté seleccionada
3. Verificar que el slot de SIM sea correcto

### WebSocket se desconecta

1. Verificar conexión a Internet
2. Revisar validez del token
3. Comprobar que el servidor esté disponible

## 📦 Dependencias

```yaml
flutter_background_service: ^5.1.0
flutter_background_service_android: ^6.3.1
flutter_local_notifications: ^18.0.1
socket_io_client: ^3.1.4
sms_sender: ^1.0.5
```

## 🔄 Ciclo de Vida

```
App Launch
    ↓
initializeService()
    ↓
Waiting for user action
    ↓
[User taps "Iniciar"]
    ↓
startService()
    ↓
Service Running in Background
    ↓
[User taps "Detener"]
    ↓
stopService()
    ↓
Service Stopped
```
