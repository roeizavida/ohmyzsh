# Proto paths
PROTO_HOME="${HOME}/.proto"
PROTO_BIN="${PROTO_HOME}/bin"
PROTO_SHIMS="${PROTO_HOME}/shims"
export PATH="${PROTO_SHIMS}:${PROTO_BIN}:${PATH}"

# Fix Proto binary for Homebrew
if [[ -f "${HOMEBREW_PREFIX}/bin/proto" ]]; then
  if [[ ! -d $PROTO_BIN ]]; then
    mkdir -p $PROTO_BIN
  fi
  if [[ ! -f "${PROTO_BIN}/proto" ]]; then
    ln -s "${HOMEBREW_PREFIX}/bin/proto" "${PROTO_BIN}/proto"
  fi
fi
