if status is-interactive
    # Commands to run in interactive sessions can go here
end

abbr -a -- sysdup 'sudo nala update && sudo nala upgrade'
abbr -a -- cd z
abbr -a -- cat 'batcat --paging=never'
abbr -a -- ls exa
abbr -a -- ll 'exa -lh'
abbr -a -- vim 'nvim'
abbr -a -- pn 'pnpm'

# pnpm
set -gx PNPM_HOME "/home/caves/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
# Created by `pipx` on 2024-02-12 20:24:12
set PATH $PATH /home/caves/.local/bin
zoxide init fish | source
