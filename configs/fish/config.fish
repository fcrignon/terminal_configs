starship init fish | source

    set -U fish_greeting '🚀 Hello there! 🍺'

set_color


# alias cd='z'

# some more ls aliases

# alias ll='ls -alF'

# alias la='ls -A'

# alias l='ls -CF'

# alias nvm

alias nvmdefault='set --universal nvm_default_version'

alias nvmu='nvm use'

# exa alias for ls

alias l='exa'

alias la='exa -a'

alias ll='exa -lah'

alias ls='exa --color=auto'

alias ...='cd ../../'

alias ....='cd ../../../'

#pnpm alias

alias pn=pnpm

alias pni='pnpm install'

alias pna='pnpm add'

alias pnad='pnpm add -D'

alias pnrm='pnpm uninstall'

alias pnup='pnpm up'

alias pnupl='pnpm up --latest'

alias pnb='pnpm build'

# bat alias

alias cat='bat --style=plain'

#git alias

alias gcl='git clone'

alias gl='git log'

alias gs='git status'

alias gd='git diff'

alias gdc='git diff --cached'

alias gc='git commit -m'

alias gma='git commit -am'

alias gcb='git branch'

alias gchb='git checkout -b'

alias gch='git checkout'

alias gchm='git checkout master'

alias gchd='git checkout develop'

alias ga='git add'

alias gra='git remote add'

alias ggpushf='git push'

alias ggpush='git push'

alias ggpull='git pull'

alias gst='git stash'

alias gstp='git stash pop'

#alias batcat

alias bat='batcat'

alias batp='batcat -p'

alias cat='batcat -p'


#alias vscode

alias c='code'

alias cc='code .'

#alias spercial fish

alias catfish='bat --style=plain ~/.config/fish/config.fish'

alias refreshfish='source ~/.config/fish/config.fish'

alias codefish='code ~/.config/fish/config.fish'



#

# end

  

# # Load nvm

# status --is-interactive; and source (nvm init -|psub)

  

# Use Node.js version 20 by default

nvm use 20

# pnpm

set -gx PNPM_HOME "/home/fcrignon/.local/share/pnpm"

if not string match -q -- $PNPM_HOME $PATH

  set -gx PATH "$PNPM_HOME" $PATH

end

# pnpm end

#pimetery tty

set -gx GPG_TTY (tty)

# zoxide

zoxide init fish | source
starship init fish | source

eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)