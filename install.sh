#!/bin/sh
# memtop installer
#   curl -fsSL https://raw.githubusercontent.com/masini/memtop/main/install.sh | sh
# Variables: PREFIX (default ~/.local/bin), MEMTOP_REF (branch/tag, default main)
set -eu

REPO="masini/memtop"
REF="${MEMTOP_REF:-main}"
PREFIX="${PREFIX:-$HOME/.local/bin}"
URL="https://raw.githubusercontent.com/$REPO/$REF/memtop"

err() { printf 'memtop: %s\n' "$*" >&2; exit 1; }

[ "$(uname -s)" = "Darwin" ] || err "macOS only"
command -v zsh >/dev/null 2>&1     || err "zsh is required"
command -v python3 >/dev/null 2>&1 || err "python3 is required (xcode-select --install)"
command -v curl >/dev/null 2>&1    || err "curl is required"

mkdir -p "$PREFIX"
TMP="$(mktemp "${TMPDIR:-/tmp}/memtop.XXXXXX")"
trap 'rm -f "$TMP"' EXIT

curl -fsSL "$URL" -o "$TMP" || err "download failed from $URL"

head -n 1 "$TMP" | grep -q '^#!/bin/zsh' || err "the downloaded file does not look like memtop"

chmod 755 "$TMP"
# mv replaces an existing symlink instead of writing through it
mv -f "$TMP" "$PREFIX/memtop"
trap - EXIT

printf 'memtop installed to %s/memtop\n' "$PREFIX"
case ":$PATH:" in
  *":$PREFIX:"*) printf 'Try: memtop  (Italian: MEMTOP_LANG=it memtop)\n' ;;
  *) printf '\n%s is not in your PATH. Add to ~/.zshrc:\n  export PATH="%s:$PATH"\n' "$PREFIX" "$PREFIX" ;;
esac
