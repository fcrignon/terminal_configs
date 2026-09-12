# Cyberpunk Neon Unicorn - Fish greeting
function fish_greeting
    # Définition des couleurs en hexadécimal (palette cyberpunk_neon)
    set -l neon_cyan "00FFFF"
    set -l neon_purple "B026FF"
    set -l neon_magenta "FF00FF"
    set -l neon_pink "FF006E"
    set -l neon_blue "00B8FF"
    set -l neon_red "FF3864"
    set -l electric_violet "8B00FF"

    # ASCII Art de la licorne avec dégradé cyberpunk
    echo
    set_color $neon_cyan
    echo "         +                                                  "
    set_color $neon_blue
    echo "            ++-                                             "
    set_color $electric_violet
    echo "                +++.           +++ +                        "
    set_color $neon_purple
    echo "                   ++++        +++ ++ + ++                  "
    set_color $neon_magenta
    echo "                      +++++-    +++++++ + -+ +              "
    echo "                         ++.+++++ +++++++++ ++ +-           "
    set_color $neon_pink
    echo "                        ++.  ++++ +++++++++++++  +          "
    echo "                      ++    ++++ ++++++++++++++++-          "
    set_color $neon_red
    echo "                     +++    + ++ +++++ ++++++++++++-        "
    echo "                    ++      ++++ ++++ ++++++++++++++        "
    set_color $neon_pink
    echo "                   ++      +++ +++  .++++++++++++++++       "
    echo "                   ++     +++-++     ++++++++++++++         "
    set_color $neon_magenta
    echo "                   ++   +++- +       +++++++++++++ ++       "
    echo "                   ++   -+-++       ++++++++++++  +++       "
    set_color $neon_purple
    echo "                   ++   ++          ++++++++++ +++++        "
    echo "                    ++.             +++++++  ++++++         "
    set_color $electric_violet
    echo "                     ++-           ++++++ ++++++++          "
    echo "                      ++ .         +++. +++++++++           "
    set_color $neon_blue
    echo "                        ++ +       +++ ++++++++             "
    set_color $neon_cyan
    echo "                          +++++       ++++++                "
    echo "                              ++++++++++                    "

    echo
    set_color $neon_cyan
    echo -n "                ◢◤◢◤ "
    set_color $neon_purple
    echo -n "C Y B E R "
    set_color $neon_magenta
    echo -n " • "
    set_color $neon_pink
    echo -n "T E R M I N A L"
    set_color $neon_cyan
    echo " ◥◣◥◣"
    echo
    set_color normal
end

alias cd='z'

# Démarre ssh-agent une seule fois par session
if not set -q SSH_AUTH_SOCK
    eval (ssh-agent -c) > /dev/null
end
ssh-add ~/.ssh/github_bazzite 2> /dev/null

# some more ls aliases
# alias ll='ls -alF'
# alias la='ls -A'
# alias l='ls -CF'

# nvm
alias nvmdefault='set --universal nvm_default_version'
alias nvmu='nvm use'

# eza alias for ls (désactivés pour l'instant, ll/ls natifs préférés)
# alias l='eza'
# alias la='eza -a'
# alias ll='eza -lah'
# alias ls='eza --color=auto'

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

# bat alias
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

# nvm (désactivé pour l'instant)
# if status is-interactive
#     nvm use 20
# end

# pnpm (désactivé pour l'instant)
# set -gx PNPM_HOME "$HOME/.local/share/pnpm"
# if not string match -q -- $PNPM_HOME $PATH
#     set -gx PATH "$PNPM_HOME" $PATH
# end

# gpg tty (needed for passphrase prompts on commit signing)
set -gx GPG_TTY (tty)

# zoxide
type -q zoxide; and zoxide init fish | source

# starship (avec prompt transitoire : le prompt courant repasse en version
# compacte une fois validé, pour ne garder le prompt complet qu'en bas)
function starship_transient_rprompt_func
    starship module cmd_duration
    starship module time
end
if type -q starship
    starship init fish | source
    enable_transience
end

# homebrew (linuxbrew)
if test -x /home/linuxbrew/.linuxbrew/bin/brew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end
