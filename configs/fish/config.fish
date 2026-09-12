if status is-interactive
    set -U fish_greeting '🚀 Hello there! 🍺'
end

# nvm
alias nvmdefault='set --universal nvm_default_version'
alias nvmu='nvm use'

# eza alias for ls (formerly exa, unmaintained upstream)
alias l='eza'
alias la='eza -a'
alias ll='eza -lah'
alias ls='eza --color=auto'
alias ...='cd ../../'
alias ....='cd ../../../'

# pnpm alias
alias pn=pnpm
alias pni='pnpm install'
alias pna='pnpm add'
alias pnad='pnpm add -D'
alias pnrm='pnpm uninstall'
alias pnup='pnpm up'
alias pnupl='pnpm up --latest'
alias pnb='pnpm build'

# bat alias (package/binary is `bat` on Fedora and via Homebrew; on
# Debian/Ubuntu without `bat-cat`->`bat` symlink, alias `bat` to `batcat`)
alias cat='bat --style=plain'
alias batp='bat -p'

# git alias
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
alias ggpush='git push'
alias ggpull='git pull'
alias gst='git stash'
alias gstp='git stash pop'

# vscode alias
alias c='code'
alias cc='code .'

# fish config shortcuts
alias catfish='bat --style=plain ~/.config/fish/config.fish'
alias refreshfish='source ~/.config/fish/config.fish'
alias codefish='code ~/.config/fish/config.fish'

if status is-interactive
    # Use Node.js version 20 by default
    type -q nvm; and nvm use 20
end

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

# gpg tty (needed for passphrase prompts on commit signing)
set -gx GPG_TTY (tty)

# zoxide + starship
type -q zoxide; and zoxide init fish | source
type -q starship; and starship init fish | source

# homebrew (linuxbrew)
if test -x /home/linuxbrew/.linuxbrew/bin/brew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end
