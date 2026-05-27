# Retro Invaders Screensaver

Un screensaver para macOS inspirado en **TI Invaders (TI-99/4A, 1981)** con colores al estilo retro: invasores verdes, azul-violeta, naranja, y OVNI amarillo.

Construido con **Swift + WKWebView + Canvas 2D** — consume recursos mínimos, sin video, sin decodificación de codec.

![preview](preview.png)

---

## Características

- 55 invasores en formación 11×5 con animación de 2 frames
- Colores por fila al estilo TI99/4A (verde, azul, violeta, naranja)
- OVNI amarillo cruzando la pantalla (sprite TI99/4A fiel)
- 4 escudos destruibles pixel a pixel
- Balas en zigzag, explosiones en el color de cada invasor
- Escala automática a cualquier resolución de pantalla
- Scanlines sutiles para efecto retro CRT
- ~0% CPU en reposo (requestAnimationFrame, 30fps cap)

---

## Requisitos

| Requisito | Versión mínima |
|-----------|---------------|
| macOS     | 12.0 Monterey |
| Xcode     | 14.0          |
| Swift     | 5.7           |

> **Apple Silicon y Intel** — El proyecto compila Universal Binary (arm64 + x86_64).

---

## Compilar e instalar

### Opción A — Script automático (recomendado)

```bash
git clone https://github.com/TU_USUARIO/RetroInvaders.git
cd RetroInvaders
chmod +x build.sh

# Solo compilar → genera RetroInvaders.saver en la carpeta actual
./build.sh

# Compilar + instalar directo en ~/Library/Screen Savers
./build.sh --install
```

El script `--install` también abre **Preferencias del Sistema → Salvapantallas** automáticamente.

### Opción B — Xcode manualmente

1. `open RetroInvaders.xcodeproj`
2. Seleccionar el scheme **RetroInvaders**
3. `Product → Build` (⌘B)
4. `Product → Show Build Folder in Finder`
5. Navegar a `Build/Products/Debug/` → doble clic en `RetroInvaders.saver`

### Opción C — Línea de comandos pura

```bash
xcodebuild build \
  -project RetroInvaders.xcodeproj \
  -scheme RetroInvaders \
  -configuration Release \
  CODE_SIGN_IDENTITY="-" \
  CODE_SIGNING_REQUIRED=NO

# Buscar el .saver
find ~/Library/Developer/Xcode/DerivedData -name "RetroInvaders.saver" -type d

# Instalar
cp -R /path/to/RetroInvaders.saver ~/Library/Screen\ Savers/
xattr -cr ~/Library/Screen\ Savers/RetroInvaders.saver
```

---

## Instalación manual del .saver

Si ya tenés el `.saver` compilado:

1. **Doble clic** en `RetroInvaders.saver` → macOS pregunta si instalar para el usuario actual o todos los usuarios.
2. Si Gatekeeper bloquea:
   ```bash
   xattr -cr ~/Library/Screen\ Savers/RetroInvaders.saver
   ```
3. Abrir **Preferencias del Sistema** → **Salvapantallas** → seleccionar *Retro Invaders*.

---

## GitHub Actions — compilar sin Xcode local

El repositorio incluye dos workflows que corren en runners macOS de GitHub:

| Workflow | Trigger | Qué hace |
|----------|---------|----------|
| `ci.yml` | Push a `develop` / PR a `main` | Compila Release, verifica el bundle, sube artifact por 7 días |
| `release.yml` | Push a `main` / manual | Compila Universal Binary, crea GitHub Release con `RetroInvaders.saver.zip` |

**Flujo recomendado:**
```
develop  →  PR  →  main
   ↓          ↓       ↓
  CI         CI    Release automático
```

**Compilar manualmente desde la web (sin Xcode, sin clonar nada):**
1. GitHub → pestaña **Actions** → **Release** → **Run workflow**
2. Esperar ~3 minutos
3. Ir a **Releases** → descargar `RetroInvaders.saver.zip`

---

## Estructura del proyecto

```
RetroInvaders/
├── RetroInvaders.xcodeproj/
│   └── project.pbxproj          # Proyecto Xcode (generado, no editar a mano)
├── RetroInvaders/
│   ├── RetroInvadersView.swift  # ScreenSaverView principal (WKWebView)
│   ├── Info.plist               # Bundle metadata
│   └── Resources/
│       └── game.html            # Juego completo en Canvas 2D + JS
├── build.sh                     # Script de compilación e instalación
└── README.md
```

---

## Arquitectura técnica

```
legacyScreenSaver.appex (macOS)
    └── RetroInvaders.saver
            └── RetroInvadersView : ScreenSaverView
                    └── WKWebView
                            └── game.html (Canvas 2D, requestAnimationFrame)
```

**¿Por qué WKWebView y no Canvas nativo en Swift?**

- WKWebView utiliza el mismo motor de rendering de Safari (WebKit), que tiene aceleración de hardware para Canvas 2D y requestAnimationFrame.
- Evita todos los bugs conocidos de Swift + ScreenSaver en macOS Sonoma/Sequoia (instancias duplicadas, `isPreview` roto, crashes con SwiftUI).
- El juego ya está 100% probado y funcionando. Cero riesgo de regressions.
- CPU usage típico: < 1% en MacBook M1/M2, ~2-3% en Intel.

---

## Consumo de recursos (referencia)

| Plataforma | CPU idle | RAM |
|-----------|----------|-----|
| M1 MacBook Air | < 1% | ~45 MB |
| Intel Core i7 2019 | ~2-3% | ~60 MB |

El original (video MP4 H.264) consumía 8-15% CPU por decodificación continua.

---

## Problemas conocidos

### macOS Sonoma / Sequoia — pantalla negra en preview
Es un bug conocido del sistema (`legacyScreenSaver.appex` con WallpaperAgent). El salvapantallas **funciona correctamente** en modo real (cuando la pantalla se activa). El preview en Preferencias puede verse negro en Sonoma 14.x.

### Gatekeeper bloquea la instalación
Ejecutar:
```bash
xattr -cr ~/Library/Screen\ Savers/RetroInvaders.saver
```

### No aparece en la lista de salvapantallas
Verificar que el bundle está en `~/Library/Screen Savers/` y reiniciar Preferencias del Sistema.

---

## Créditos

- Juego original: **TI Invaders** — Texas Instruments, 1981
- Screensaver: **OperiaTech / Dr. Hugo Daniel Dabien**
- Paleta de colores inspirada en el chip **TMS9918A** del TI-99/4A

---

## Licencia

MIT — ver `LICENSE`
