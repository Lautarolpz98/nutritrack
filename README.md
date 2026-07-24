# 🥗 NutriTrack

**Asistente de nutrición offline-first para Android, construido con Flutter.**

NutriTrack te ayuda a registrar tu alimentación, ejercicio, sueño, hidratación y peso — todo guardado localmente en tu dispositivo, sin backend, sin cuentas y 100% gratis. Las funciones de inteligencia artificial son opcionales y funcionan con tu propia API key de Google Gemini (modelo *bring-your-own-key*).

## ✨ Funcionalidades

### Registro de comidas por tres vías
- **Manual**: nombre, calorías, macros, porción y momento del día.
- **Escáner de código de barras**: consulta [Open Food Facts](https://world.openfoodfacts.org) y precarga los datos nutricionales; los productos consultados quedan cacheados para funcionar offline.
- **Foto con IA** 📸: sacale una foto al plato y Gemini estima los alimentos, porciones, calorías y macros. Todo se revisa y corrige en una pantalla editable antes de guardar — siempre con el aviso de que es una estimación.

### Seguimiento diario
- **Dashboard** con anillo de progreso de calorías (consumidas vs. objetivo), barras de macros y accesos rápidos.
- **Contador de pasos** 🚶 con el sensor del teléfono: pasos del día contra tu objetivo, con calorías estimadas que se suman a las quemadas.
- **Ejercicio** con cálculo automático de calorías por tablas MET, y rutinas del día sugeridas por IA (elegís **gimnasio** o **en casa con poco equipamiento**) según tu perfil e historial.
- **Sueño** por duración directa u horarios de acostarse/levantarse.
- **Agua** en litros, con objetivo diario según tu peso (35 ml/kg) y botón rápido de +250 ml.
- **Peso corporal** con gráfico de evolución.

### Multi-usuario sin cuentas
- Hasta **3 usuarios** en el mismo teléfono, sin registro ni contraseñas: cada uno tiene su propia base de datos local, con datos e historial totalmente aislados.

### Historial y datos
- **Calendario**: tocá cualquier día y mirá su resumen completo.
- **Gráficos** de 7/30 días: calorías, peso y sueño (fl_chart).
- **Exportación a CSV** de todos tus datos.

### Perfil y objetivos
- Onboarding con cálculo de TMB (**Mifflin-St Jeor**), gasto diario según nivel de actividad y objetivo calórico ajustable.
- Objetivos de macros (30/40/30), agua (35 ml/kg) y sueño.
- Unidades kg/lb y tema claro/oscuro.

## 🔒 Privacidad primero

- **Todos los datos viven en tu dispositivo** (SQLite local). No hay servidores propios ni analytics.
- La API key de Gemini se guarda **cifrada** con el Keystore de Android (`flutter_secure_storage`) y solo viaja a `generativelanguage.googleapis.com`.
- Sin API key, la app funciona completa igual — solo se desactivan las funciones de IA.

## 🛠️ Stack técnico

| Capa | Tecnología |
|---|---|
| Framework | Flutter (Dart, null safety) |
| Estado | Riverpod 3 |
| Base de datos | Drift (SQLite reactivo) |
| Navegación | go_router |
| HTTP | dio |
| Gráficos | fl_chart |
| Escáner | mobile_scanner |
| Cámara/galería | image_picker |
| Seguridad | flutter_secure_storage |
| IA | Google Gemini API (REST, BYOK) |

## 🏗️ Arquitectura

Clean architecture liviana, organizada por *features*:

```
lib/
├── app/                  # Router y arranque
├── core/
│   ├── database/         # Esquema Drift (7 tablas) y provider
│   ├── ia/               # GeminiApiService + almacenamiento seguro de la key
│   ├── modelos/          # Enums compartidos
│   └── preferencias/     # Tema persistido
└── features/
    ├── perfil/           # Onboarding, TMB, unidades
    ├── comidas/          # Manual + barcode + foto IA
    ├── ejercicio/        # MET + rutinas IA
    ├── sueno/            # Sueño, agua, peso
    ├── dashboard/        # Pantalla principal
    ├── historial/        # Calendario, gráficos, CSV
    └── ajustes/          # API key, preferencias, datos
```

Cada feature separa `data` (repositorios sobre Drift), `domain` (lógica pura testeable) y `presentation` (pantallas + providers). Las llamadas a la IA devuelven resultados tipados con *sealed classes* genéricas (`ResultadoIA<T>`), lo que obliga a manejar todos los casos de error (sin key, sin internet, rate limit, respuesta no parseable) en tiempo de compilación.

## 🚀 Cómo correrlo

Requisitos: Flutter estable y un dispositivo/emulador Android.

```bash
git clone https://github.com/Lautarolpz98/nutritrack.git
cd nutritrack
flutter pub get
dart run build_runner build        # genera el código de Drift
flutter run
```

Para compilar el APK de release:

```bash
flutter build apk --release --split-per-abi
```

### Activar las funciones de IA (opcional y gratis)

1. Creá una API key en [Google AI Studio](https://aistudio.google.com) (capa gratuita, sin tarjeta).
2. En la app: ⚙️ Ajustes → pegá la key → *Guardar* → *Probar conexión*.

El servicio detecta automáticamente el mejor modelo Gemini disponible para tu key, con *fallback* si Google rota los modelos.

## ✅ Tests

46 tests unitarios sobre la lógica de negocio (cálculo energético, tablas MET, parseo robusto de respuestas de IA, mapeo de Open Food Facts, conversión de unidades, generación de CSV):

```bash
flutter test
```

## 📄 Licencia

[MIT](LICENSE) — Lautaro López
