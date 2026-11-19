#!/bin/sh
# Installer di memtop
#   curl -fsSL https://raw.githubusercontent.com/masini/memtop/main/install.sh | sh
# Variabili: PREFIX (default ~/.local/bin), MEMTOP_REF (branch/tag, default main)
set -eu

REPO="masini/memtop"
REF="${MEMTOP_REF:-main}"
PREFIX="${PREFIX:-$HOME/.local/bin}"
URL="https://raw.githubusercontent.com/$REPO/$REF/memtop"

err() { printf 'memtop: %s\n' "$*" >&2; exit 1; }

[ "$(uname -s)" = "Darwin" ] || err "funziona solo su macOS"
command -v zsh >/dev/null 2>&1     || err "serve zsh"
command -v python3 >/dev/null 2>&1 || err "serve python3 (xcode-select --install)"
command -v curl >/dev/null 2>&1    || err "serve curl"

mkdir -p "$PREFIX"
TMP="$(mktemp "${TMPDIR:-/tmp}/memtop.XXXXXX")"
trap 'rm -f "$TMP"' EXIT

curl -fsSL "$URL" -o "$TMP" || err "download fallito da $URL"

head -n 1 "$TMP" | grep -q '^#!/bin/zsh' || err "il file scaricato non sembra memtop"

chmod 755 "$TMP"
# mv sostituisce l'eventuale symlink invece di scriverci attraverso
mv -f "$TMP" "$PREFIX/memtop"
trap - EXIT

printf 'memtop installato in %s/memtop\n' "$PREFIX"
case ":$PATH:" in
  *":$PREFIX:"*) printf 'Prova: memtop\n' ;;
  *) printf '\n%s non è nel PATH. Aggiungi a ~/.zshrc:\n  export PATH="%s:$PATH"\n' "$PREFIX" "$PREFIX" ;;
esac
