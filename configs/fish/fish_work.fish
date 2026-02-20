# Commands to run in interactive sessions can go here
starship init fish | source
    set -U fish_greeting '🚀 Hello there! 🍺'
set_color

#some cd aliases with zioxid
alias cdot='z ~/workspace/kering/dott'
alias cdotpbl='z ~/workspace/kering/dott/pay-by-link/ecom-paybylink-app/'
alias cdotomsf='z ~/workspace/kering/dott/omsf/'
# alias cd='z'
# some more ls aliases
# alias ll='ls -alF'
# alias la='ls -A'
# alias l='ls -CF'
# alias fdfind
alias fd='fdfind'
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
#alias special DOTT
alias cprc='cp ~/workspace/kering/dott/.npmrc .' 
alias gred='git rebase develop'
alias greod='git rebase origine develop'
alias addbump='cp ~/workspace/kering/dott/sandbox/bump.sh ./dev'
#alias vscode
alias c='code'
alias cc='code .'
#alias spercial fish
alias catfish='bat --style=plain ~/.config/fish/config.fish'
alias refreshfish='source ~/.config/fish/config.fish'
alias codefish='code ~/.config/fish/config.fish'
#alias bump
alias bump='~/workspace/kering/script/bump.sh'
#alias add github action
alias add_gha_dott='~/workspace/kering/script/add_github_action_1.sh'
alias add_gha_cg='~/workspace/kering/script/add_github_action_CG.sh'
alias initp='~/workspace/kering/script/initDottProject.sh'
#
# end

# # Load nvm
# status --is-interactive; and source (nvm init -|psub)

# Use Node.js version 20 by default
if status is-interactive
  # Only run interactive shell commands here
  # e.g., nvm use default
  nvm use 20
end
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
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
