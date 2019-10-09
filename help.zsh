# help - simple tldr wrapper that falls back to man

(( $+functions[help] )) && return

(( $+commands[tldr] )) && function help {
  if [[ $# = 0 ]]; then command cat <<<'help v0.1.0

help [--os <type>] <command|all>

  <type>    linux, osx, sunos, other
     all    List all commands

Try `help --os linux tar`'; return; fi
  [[ "$*" == "all" ]] && { tldr --list && return }
  { tldr -q $* || tldr -q -o linux $* || tldr -q -o osx $* || tldr -q -o sunos $* || tldr -q -o windows $* } && return
  command ${functions[man]:-${commands[man]}} $*
}

(( $+functions[h] )) || alias h=help
