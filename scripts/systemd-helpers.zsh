# shellcheck shell=bash
# Systemd helper aliases and functions sourced lazily from the shell profile.

case "$(uname -s 2>/dev/null)" in
  Linux) ;;
  *)
    return 0 2>/dev/null || exit 0
    ;;
esac

if ! command -v systemctl >/dev/null 2>&1; then
  return 0 2>/dev/null || exit 0
fi

alias s='sudo systemctl'
alias sj='journalctl'
alias u='systemctl --user'
alias uj='journalctl --user'

_sysls() {
  local wide="$1"
  local states="${2-}"
  local -a state_flags=()

  if [ -n "$states" ]; then
    state_flags=("--state=$states")
  fi

  if ! command -v fzf >/dev/null 2>&1; then
    printf 'fzf is required for %s\n' "$wide" >&2
    return 1
  fi

  command cat \
    <(printf '%s\n' 'UNIT/FILE LOAD/STATE ACTIVE/PRESET SUB DESCRIPTION') \
    <(command systemctl "$wide" list-units --legend=false "${state_flags[@]}") \
    <(command systemctl "$wide" list-unit-files --legend=false "${state_flags[@]}") \
    | command sed 's/●/ /' \
    | command grep '.' \
    | command column --table --table-columns-limit=5 \
    | command fzf \
        --header-lines=1 \
        --accept-nth=1 \
        --no-hscroll \
        --preview="SYSTEMD_COLORS=1 systemctl $wide status {1}" \
        --preview-window=down
}

alias sls='_sysls --system'
alias uls='_sysls --user'
alias sjf='sj --unit $(uls) --all --follow'
alias ujf='uj --unit $(uls) --all --follow'

_SYS_ALIASES=(
  sstart sstop sre
  ustart ustop ure
)

_SYS_CMDS=(
  's start $(sls static,disabled,failed)'
  's stop $(sls running,failed)'
  's restart $(sls)'
  'u start $(uls static,disabled,failed)'
  'u stop $(uls running,failed)'
  'u restart $(uls)'
)

_sysexec() {
  local alias_name="$1"
  local cmd wide

  for ((j=0; j < ${#_SYS_ALIASES[@]}; j++)); do
    if [ "$alias_name" = "${_SYS_ALIASES[$j]}" ]; then
      cmd=$(eval "echo ${_SYS_CMDS[$j]}")
      wide=${cmd:0:1}
      cmd="$cmd && ${wide} status \\$_ || ${wide}j -xeu \\$_"
      eval "$cmd"

      if [ -n "${BASH_VERSION-}" ]; then
        history -s "$cmd"
      elif [ -n "${ZSH_VERSION-}" ]; then
        print -s -- "$cmd"
      fi
      return 0
    fi
  done
}

for alias_name in "${_SYS_ALIASES[@]}"; do
  eval "${alias_name}() { _sysexec ${alias_name}; }"
done
