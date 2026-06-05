# Falstad Circuit Simulator — Linux Installer

Downloads the official Linux x86_64 build from falstad.com and installs it locally.

## Install

```bash
curl -fsSL https://github.com/jpnski/falstad-linux/raw/main/install.sh | bash
```

Or with a custom path:

```bash
curl -fsSL https://github.com/jpnski/falstad-linux/raw/main/install.sh | bash -s -- --path=/opt/circuitjs1
```

## What it does

After running, two directories are created:

```
~/.local/share/applications/
└── circuitjs1.desktop        ← app menu entry (rofi, GNOME, KDE, etc.)

~/.local/share/circuitjs1/
├── circuitjs1                ← the program
├── resources/                ← circuit simulator code
├── lib*.so, *.pak, ...       ← Electron/Chromium runtime
└── icon.png                  ← app icon
```

Launch **Falstad Circuit Simulator** from your application launcher.
