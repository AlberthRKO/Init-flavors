# Flavors Configuration

Este proyecto utiliza **flavors** de Flutter para manejar diferentes configuraciones de la aplicación (development, staging, production, cliente1, cliente2).

## Flavors Disponibles

- **development**: Versión de desarrollo con ID `com.fiscalia.gw_sms.dev`
- **staging**: Versión de pruebas con ID `com.fiscalia.gw_sms.stg`
- **production**: Versión de producción con ID `com.fiscalia.gw_sms`
- **cliente1**: Versión personalizada para Cliente 1 con ID `com.fiscalia.gw_sms.cliente1`
- **cliente2**: Versión personalizada para Cliente 2 con ID `com.fiscalia.gw_sms.cliente2`

## Ejecutar la Aplicación

### Desde VS Code

Usa las configuraciones de launch predefinidas en `.vscode/launch.json`:

- Launch development
- Launch staging
- Launch production
- Launch cliente1 (debug/profile/release)
- Launch cliente2 (debug/profile/release)

### Desde Terminal

```bash
# Development
flutter run --flavor development --target lib/main_development.dart

# Staging
flutter run --flavor staging --target lib/main_staging.dart

# Production
flutter run --flavor production --target lib/main_production.dart

# Cliente1
flutter run --flavor cliente1 --target lib/main_cliente1.dart

# Cliente2
flutter run --flavor cliente2 --target lib/main_cliente2.dart
```

## Generar APKs

### APK de Debug (para pruebas rápidas)

```bash
# Development
flutter build apk --flavor development --target lib/main_development.dart --debug

# Staging
flutter build apk --flavor staging --target lib/main_staging.dart --debug

# Production
flutter build apk --flavor production --target lib/main_production.dart --debug

# Cliente1
flutter build apk --flavor cliente1 --target lib/main_cliente1.dart --debug

# Cliente2
flutter build apk --flavor cliente2 --target lib/main_cliente2.dart --debug
```

**Ubicación**: `build/app/outputs/flutter-apk/app-<flavor>-debug.apk`

### APK de Profile (para testing de rendimiento)

```bash
# Development
flutter build apk --flavor development --target lib/main_development.dart --profile

# Staging
flutter build apk --flavor staging --target lib/main_staging.dart --profile

# Production
flutter build apk --flavor production --target lib/main_production.dart --profile

# Cliente1
flutter build apk --flavor cliente1 --target lib/main_cliente1.dart --profile

# Cliente2
flutter build apk --flavor cliente2 --target lib/main_cliente2.dart --profile
```

**Ubicación**: `build/app/outputs/flutter-apk/app-<flavor>-profile.apk`

### APK de Release (para distribución)

⚠️ **Importante**: Requiere configurar el archivo `key.properties` en `android/` con tu keystore para firmar la app.

```bash
# Development
flutter build apk --flavor development --target lib/main_development.dart --release

# Staging
flutter build apk --flavor staging --target lib/main_staging.dart --release

# Production
flutter build apk --flavor production --target lib/main_production.dart --release

# Cliente1
flutter build apk --flavor cliente1 --target lib/main_cliente1.dart --release

# Cliente2
flutter build apk --flavor cliente2 --target lib/main_cliente2.dart --release
```

**Ubicación**: `build/app/outputs/flutter-apk/app-<flavor>-release.apk`

### APK Split por ABI (recomendado para Play Store)

Para generar APKs optimizados por arquitectura (reduce tamaño):

```bash
# Ejemplo con production
flutter build apk --flavor production --target lib/main_production.dart --release --split-per-abi
```

Esto genera 3 APKs separados:

- `app-production-armeabi-v7a-release.apk` (32-bit ARM)
- `app-production-arm64-v8a-release.apk` (64-bit ARM)
- `app-production-x86_64-release.apk` (64-bit x86)

**Ubicación**: `build/app/outputs/flutter-apk/`

## Generar App Bundle (AAB) para Play Store

El formato recomendado por Google Play Store:

```bash
# Development
flutter build appbundle --flavor development --target lib/main_development.dart --release

# Staging
flutter build appbundle --flavor staging --target lib/main_staging.dart --release

# Production
flutter build appbundle --flavor production --target lib/main_production.dart --release

# Cliente1
flutter build appbundle --flavor cliente1 --target lib/main_cliente1.dart --release

# Cliente2
flutter build appbundle --flavor cliente2 --target lib/main_cliente2.dart --release
```

**Ubicación**: `build/app/outputs/bundle/<flavor>Release/app-<flavor>-release.aab`

## Configuración de Firma (Keystore)

Para builds de release, crea `android/key.properties`:

```properties
storePassword=tu_store_password
keyPassword=tu_key_password
keyAlias=tu_key_alias
storeFile=/ruta/a/tu/keystore.jks
```

O usa variables de entorno en CI/CD:

- `ANDROID_KEYSTORE_PATH`
- `ANDROID_KEYSTORE_ALIAS`
- `ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD`
- `ANDROID_KEYSTORE_PASSWORD`

## Comandos Útiles

### Limpiar builds anteriores

```bash
flutter clean
flutter pub get
```

### Ver todos los dispositivos conectados

```bash
flutter devices
```

### Instalar APK directamente en dispositivo conectado

```bash
flutter install --flavor production --target lib/main_production.dart
```

### Analizar tamaño del APK

```bash
flutter build apk --flavor production --target lib/main_production.dart --release --analyze-size
```

## Diferencias entre Builds

| Build Type  | Optimización | Tamaño  | Debug Tools | Uso                     |
| ----------- | ------------ | ------- | ----------- | ----------------------- |
| **debug**   | Baja         | Grande  | ✅ Sí       | Desarrollo local        |
| **profile** | Media        | Mediano | ⚠️ Parcial  | Testing de rendimiento  |
| **release** | Alta         | Pequeño | ❌ No       | Producción/Distribución |

## Notas Importantes

1. **Debug APK**: No requiere firma, útil para pruebas rápidas pero más pesado
2. **Release APK**: Requiere keystore configurado, optimizado y minificado
3. **App Bundle (AAB)**: Formato preferido por Play Store, genera APKs optimizados por dispositivo
4. **Split APKs**: Reduce tamaño pero genera múltiples archivos

## Troubleshooting

### Error: "Keystore file not found"

Asegúrate de crear `android/key.properties` con la configuración correcta.

### APK muy grande

Usa `--split-per-abi` o genera un App Bundle en su lugar.

### No se puede instalar APK

Verifica que no tengas otra versión con el mismo package name instalada.
