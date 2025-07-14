# SpaceExplorer

**SpaceExplorer** es una aplicación Flutter que permite explorar el contenido de la NASA a través de su API oficial. La app tiene los siguientes features:

- Imagen astronómica del día (APOD)
- Fotos de los rovers en Marte
- Eventos naturales recientes (EONET)
- Búsqueda de imágenes en la biblioteca multimedia de la NASA
- Gestión de favoritos
- Preferencias como modo oscuro y modo compacto
- Funcionalidad de compartir contenido
- Soporte offline para datos clave

## Características

- Navegación con Drawer lateral
- Filtros con persistencia local (SharedPreferences)
- Temas personalizados (light/dark y compacto)
- Manejo de conexión a Internet
- Acceso a múltiples endpoints de NASA
- Uso de `Provider` para la gestión de estado

##  Estructura del Proyecto

lib/
│
├── core/               # Servicios (API, conexión, etc.)
├── models/             # Modelos de datos (APOD, Rover, EONET, etc.)
├── screens/            # Pantallas de la app
├── widgets/            # Componentes reutilizables
├── theme/              # Temas y ThemeProvider
├── assets/             # Imágenes y fondos
└── main.dart           # Entrada principal

## Tecnologías

- Flutter 
- Provider
- Share Plus
- Shared Preferences
- NASA APIs (APOD, DONKI, EONET, Mars Rover, Search API)


## Instalación

```bash
git clone https://github.com/Juan-Rabay/SpaceExplorer.git
cd spaceexplorer
flutter pub get
flutter run
apk dir: build/app/outputs/flutter-apk/app-release.apk
## Autores

- Felipe Pérez
- Juan Rabay

Proyecto universitario – *PDS3-2501* (Universidad de Talca)