#!/bin/sh
# TamidaS Modbus Simulator — installer for macOS and Linux.
#
#   curl -fsSL https://raw.githubusercontent.com/TamidaSRepo/modbus-simulator/main/install.sh | sh
#
# Downloads the build for this machine, verifies its SHA-256 checksum, installs it under
# ~/.local/share/tamidas-modbus-simulator and links it into ~/.local/bin. On macOS the
# quarantine flag is removed as well (the builds are notarised; this just avoids the one-time
# confirmation and lets an offline Mac start it). Nothing needs root.
#
# Environment overrides: VERSION (default 1.0.0), PREFIX (bin dir, default ~/.local/bin),
# BASE_URL (where the archives are fetched from).
set -e

VERSION="${VERSION:-1.0.0}"
BASE_URL="${BASE_URL:-https://raw.githubusercontent.com/TamidaSRepo/modbus-simulator/main}"
PREFIX="${PREFIX:-$HOME/.local/bin}"
APP_DIR="${APP_DIR:-$HOME/.local/share/tamidas-modbus-simulator}"

case "$(uname -s)" in
  Darwin) plat=macos ;;
  Linux)  plat=linux ;;
  *) echo "Unsupported operating system: $(uname -s). Use the Windows executable or build from source." >&2; exit 1 ;;
esac
case "$(uname -m)" in
  x86_64|amd64)  arch=x64 ;;
  arm64|aarch64) arch=arm64 ;;
  *) echo "Unsupported CPU architecture: $(uname -m)" >&2; exit 1 ;;
esac
if [ "$plat" = linux ] && ldd --version 2>&1 | grep -qi musl; then
  echo "This build needs glibc (Debian, Ubuntu, Fedora, RHEL…); Alpine/musl is not supported." >&2; exit 1
fi

file="tamidas-modbus-simulator-$VERSION-$plat-$arch.tar.gz"
bin="tamidas-modbus-simulator-$plat-$arch"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

echo "Downloading $file …"
curl -fsSL -o "$tmp/$file" "$BASE_URL/$file"

# Verify the checksum when the sums file is published next to the archives.
if curl -fsSL -o "$tmp/SHA256SUMS" "$BASE_URL/SHA256SUMS" 2>/dev/null; then
  expected="$(grep " $file\$" "$tmp/SHA256SUMS" | cut -d' ' -f1)"
  if command -v sha256sum >/dev/null 2>&1; then actual="$(sha256sum "$tmp/$file" | cut -d' ' -f1)"
  else actual="$(shasum -a 256 "$tmp/$file" | cut -d' ' -f1)"; fi
  if [ -n "$expected" ] && [ "$expected" != "$actual" ]; then
    echo "Checksum mismatch for $file — download corrupted or tampered with. Nothing installed." >&2; exit 1
  fi
  [ -n "$expected" ] && echo "Checksum OK."
fi

tar xzf "$tmp/$file" -C "$tmp"
mkdir -p "$APP_DIR" "$PREFIX"
mv -f "$tmp/$bin" "$APP_DIR/tamidas-modbus-simulator"
chmod 755 "$APP_DIR/tamidas-modbus-simulator"
[ "$plat" = macos ] && xattr -d com.apple.quarantine "$APP_DIR/tamidas-modbus-simulator" 2>/dev/null || true
ln -sf "$APP_DIR/tamidas-modbus-simulator" "$PREFIX/tamidas-modbus-simulator"

echo
echo "Installed: $APP_DIR/tamidas-modbus-simulator"
echo "Command:   tamidas-modbus-simulator        (settings are kept in $APP_DIR/data)"
case ":$PATH:" in
  *":$PREFIX:"*) ;;
  *) echo "Note: $PREFIX is not on your PATH. Add this to your shell profile:  export PATH=\"$PREFIX:\$PATH\"" ;;
esac
if [ "$plat" = linux ]; then
  if ! id -nG 2>/dev/null | grep -qwE 'dialout|uucp'; then
    echo "Serial (RTU/ASCII): add yourself to the serial group, then log out and in:  sudo usermod -aG dialout $USER"
  fi
  echo "TCP port 502 needs privileges on Linux; use a port above 1024 (e.g. 5020) or run once:"
  echo "  sudo setcap 'cap_net_bind_service=+ep' $APP_DIR/tamidas-modbus-simulator"
fi
echo
echo "Start it now with:  tamidas-modbus-simulator"
