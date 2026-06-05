#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="${HOME}/.local/share/circuitjs1"
DESKTOP_DIR="${HOME}/.local/share/applications"

# Allow custom path (e.g., bash install.sh --path=/opt/circuitjs1)
for arg in "$@"; do
  case "$arg" in
    --path=*) INSTALL_DIR="${arg#*=}" ;;
  esac
done

# Guard: Linux x86_64 only
[ "$(uname -s)" = "Linux" ]   || { echo "Only Linux is supported." >&2; exit 1; }
[ "$(uname -m)" = "x86_64" ]  || { echo "Only x86_64 is supported." >&2; exit 1; }
command -v curl >/dev/null    || { echo "Install curl and re-run." >&2; exit 1; }

mkdir -p "$INSTALL_DIR" "$DESKTOP_DIR"

echo "Downloading Falstad Circuit Simulator..."
curl -fsSL --progress-bar \
  "https://www.falstad.com/circuit/offline/circuitjs1-linux64.tgz" \
  | tar -xzf - -C "$INSTALL_DIR"

[ -x "$INSTALL_DIR/circuitjs1" ] || { echo "Extraction failed — binary not found." >&2; exit 1; }

echo "Downloading icon..."
curl -fsSL -o "$INSTALL_DIR/icon.png" \
  "https://www.falstad.com/circuit/icon512.png" || true

echo "Creating desktop entry..."
cat > "$DESKTOP_DIR/circuitjs1.desktop" <<EOF
[Desktop Entry]
Name=Falstad Circuit Simulator
Comment=Interactive Electronic Circuit Simulator
Exec=${INSTALL_DIR}/circuitjs1 %F
Icon=${INSTALL_DIR}/icon.png
Terminal=false
Type=Application
Categories=Education;Electronics;Science;
Keywords=circuit;simulator;electronics;
EOF

echo "Done — launch Falstad from your app menu (rofi, GNOME, KDE, etc.)."
