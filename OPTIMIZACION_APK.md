# Optimización de APK para Tablets Antiguas

## Problema Actual

- APK: 200 MB (muy pesado para tablets antiguas)
- Objetivo: Reducir a 50-80 MB

## Causas Principales

1. **Múltiples arquitecturas** - APK incluye código para arm64, armv7, x86
2. **Assets sin optimizar** - GIFs y imágenes en alta calidad
3. **Dependencias innecesarias**
4. **Código no minificado**

---

## Solución 1: APK Split por Arquitectura (RECOMENDADO) ⭐

**Por qué:** La tablet SMT505 es antigua (probablemente ARMv7). El APK actual incluye código para múltiples arquitecturas.

### Paso 1: Verificar arquitectura de tu tablet

```bash
# Conecta la tablet y ejecuta:
adb shell getprop ro.product.cpu.abi
```

**Resultado esperado:**

- `armeabi-v7a` (ARM 32-bit) - tablets antiguas
- `arm64-v8a` (ARM 64-bit) - tablets modernas
- `x86` o `x86_64` - tablets raras

### Paso 2: Compilar APK splits (MEJOR OPCIÓN)

```bash
# Crear APKs separados para cada arquitectura
flutter build apk --split-per-abi --release

# Esto genera:
# - build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk (~50-70 MB)
# - build/app/outputs/flutter-apk/app-arm64-v8a-release.apk (~60-80 MB)
# - build/app/outputs/flutter-apk/app-x86-release.apk (~50-70 MB)
```

**Ventaja:** Cada APK es 50-60% más pequeño

### Paso 3: Instalar APK correcto en tu tablet

```bash
# Para tablets antiguas (ARMv7)
adb install build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk

# Para tablets modernas (ARM64)
adb install build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
```

---

## Solución 2: Compilar Solo para ARMv7 (Más Agresivo)

Si solo necesitas tablets antiguas:

```bash
# Compilar SOLO para arquitectura ARMv7
flutter build apk --target-platform=android-arm --release

# Resultado esperado: 60-80 MB
```

---

## Solución 3: App Bundle para Google Play (ALTERNATIVA)

Si planeas distribuir por Google Play Store:

```bash
# Crear App Bundle (Google Play optimiza automáticamente)
flutter build appbundle --release

# Archivo: build/app/outputs/bundle/release/app-release.aab (~100-150 MB)
# Los usuarios descargan solo ~60-80 MB
```

---

## Solución 4: Optimizaciones Adicionales

### 4.1 - Reducir tamaño de imágenes

```bash
# Ver tamaño de assets
du -sh assets/

# Comprimir GIFs
# Herramienta: https://ezgif.com/
# Reducir resolución de imágenes que no necesitan alta calidad
```

### 4.2 - Eliminar dependencias no usadas

Revisa en `pubspec.yaml`:

```yaml
# REVISAR SI ESTÁN EN USO:
cached_network_image: # Para caché de imágenes
flutter_svg: # Para SVGs
lottie: # Para animaciones
```

Para verificar:

```bash
# Analizar dependencias no usadas
flutter pub deps --no-dev
```

### 4.3 - Minificación (Habilitar ProGuard/R8)

Editar `android/app/build.gradle.kts`:

```kotlin
android {
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}
```

---

## Solución 5: Compilación Optimizada Completa

```bash
# Versión optimizada máxima:
flutter clean
flutter pub get
flutter build apk \
    --split-per-abi \
    --target-platform=android-arm \
    --release \
    --verbose
```

---

## Pasos Recomendados (En Orden)

### ✅ Paso 1: Crear APK Split (5 min)

```bash
flutter build apk --split-per-abi --release
```

### ✅ Paso 2: Probar en tablet

```bash
adb install -r build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk
```

### ✅ Paso 3: Si aún es pesado, optimizar assets

- Comprimir imágenes GIFs
- Remover SVGs no utilizados

### ✅ Paso 4: Si aún es pesado, revisar dependencias

```bash
flutter pub deps --no-dev
```

---

## Comparativa de Tamaño Esperado

| Método                                            | Tamaño                    | Tiempo Compilación |
| ------------------------------------------------- | ------------------------- | ------------------ |
| `flutter build apk --release`                     | ~200 MB                   | 5 min              |
| `flutter build apk --split-per-abi`               | ~60 MB (ARMv7)            | 10 min             |
| `flutter build apk --target-platform=android-arm` | ~70 MB                    | 5 min              |
| `flutter build appbundle`                         | ~100 MB (descarga ~60 MB) | 5 min              |

---

## Debugging de Tamaño

### Ver composición del APK

```bash
# Instalar Android Studio (si no lo tienes)
# Abrir APK con: Analyze > Analyze APK

# O por terminal:
unzip -l build/app/outputs/flutter-apk/app-release.apk | head -50
```

### Ver qué ocupa más espacio

```bash
# ARMv7 libflutter.so (motor Dart)
unzip -l build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk | grep "\.so"
```

---

## Comandos Rápidos de Referencia

```bash
# Split por arquitectura (RECOMENDADO)
flutter build apk --split-per-abi --release

# Solo ARM 32-bit (tablets antiguas)
flutter build apk --target-platform=android-arm --release

# App Bundle para Play Store
flutter build appbundle --release

# Instalar en device
adb install -r app-armeabi-v7a-release.apk

# Ver device conectado
adb devices
```

---

## Especificaciones de tu Tablet SMT505

**Nota:** Samsung Galaxy Tab Active Pro (SMT505) tiene:

- **CPU:** ARM Cortex-A53 (ARMv7/ARMv8)
- **RAM:** 3-4 GB
- **Android:** 9.0 Pie (2019)
- **Recomendación:** Usar `--split-per-abi` o `--target-platform=android-arm`

---

## ¿Aún muy pesado? Pasos adicionales:

1. **Revisar `build.gradle` del app:**
   - Desactivar soporte para arquitecturas no necesarias
   - Eliminar assets de splashes innecesarios

2. **Comprimir fuentes de fonts:**
   - Incluir solo los weights que uses

3. **Revisar imágenes GIFs:**
   - Convertir a videos WebM o MP4 (más eficientes)

---

## Soporte

Si después de esto sigue siendo pesado, ejecuta:

```bash
flutter doctor -v
flutter analyze
```

Y revisa qué dependencias están usando más espacio.

# Compilar y instalar

flutter build apk --flavor production --target lib/main_production.dart --split-per-abi --debug

# Instalar en tablet

adb install -r build/app/outputs/flutter-apk/app-armeabi-v7a-production-debug.apk
