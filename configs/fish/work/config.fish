# ╔══════════════════════════════════════════════════════╗
# ║              Fish Shell Config          ║
# ╚══════════════════════════════════════════════════════╝

# ── Session interactive uniquement ──────────────────────
if status is-interactive

    type -q starship; and starship init fish | source
    set -U fish_greeting '🚀 Hello there! 🍺'

    # Zoxide (remplace cd)
    type -q zoxide; and zoxide init fish --cmd cd | source

    # SSH agent
    if not set -q SSH_AUTH_SOCK
        eval (ssh-agent | grep -v echo | string replace -r '(.*);' '$1')
    end
    type -q bass; and bass keychain --eval --quiet ~/.ssh/github_signin_kering ~/.ssh/github_auth_kering 2>/dev/null 1>/dev/null

    # # NVM : version par défaut silencieuse
    # nvm use 20 --silent

end

# ── Homebrew ─────────────────────────────────────────────
if test -x /home/linuxbrew/.linuxbrew/bin/brew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

# ── Variables d'environnement ────────────────────────────
set -gx EDITOR code
set -gx VISUAL code
set -gx TERM xterm-256color
set -gx GPG_TTY (tty)

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path $PNPM_HOME

# fzf
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git"'
set -gx FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'

# PATH local
fish_add_path $HOME/.local/bin

# ── Auto-switch node via .nvmrc ──────────────────────────
source ~/.config/fish/functions/_auto_switch_node.fish

# ── Complétions alias git ────────────────────────────────
complete -c gcl -xa '(git branch --no-color 2>/dev/null | string replace -r "^" "")'
complete -c gch -xa '(git branch --no-color 2>/dev/null | string replace -r "\\*\\s" "")'

# ── Alias — navigation ───────────────────────────────────
alias ...='cd ../../'
alias ....='cd ../../../'
alias cdot='cd ~/workspace/kering/dott'
alias cdotpbl='cd ~/workspace/kering/dott/pay-by-link/ecom-paybylink-app/'
alias cdotomsf='cd ~/workspace/kering/dott/omsf/'

# ── Alias — ls (eza) ─────────────────────────────────────
alias l='eza --grid'
alias la='eza --all'
alias ll='eza --long --header --git'
alias ls='eza --color=always --grid'

# ── Alias — outils ───────────────────────────────────────
alias fd='fdfind'
alias bat='batcat'
alias batp='batcat -p'
alias cat='bat'
alias c='code'
alias cc='code .'
alias lg='lazygit'
alias ld='lazydocker'
alias sf='superfile'
alias top='btop'
alias gcs='gh copilot suggest'
alias gce='gh copilot explain'

# ── Alias — fish ─────────────────────────────────────────
alias catfish='bat --style=plain ~/.config/fish/config.fish'
alias refreshfish='source ~/.config/fish/config.fish'
alias codefish='code ~/.config/fish/config.fish'
alias cprc='safe_cp_npmrc'

# ── Alias — nvm ──────────────────────────────────────────
alias nvmdefault='set --universal nvm_default_version'
alias nvmu='nvm use'

# ── Alias — pnpm ─────────────────────────────────────────
alias pn=pnpm
alias pni='pnpm install'
alias pna='pnpm add'
alias pnad='pnpm add -D'
alias pnrm='pnpm uninstall'
alias pnup='pnpm up'
alias pnupl='pnpm up --latest'
alias pnb='pnpm build'

# ── Alias — git ──────────────────────────────────────────
alias gcl='git clone'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gc='git commit -m'
alias gcsm='git commit -S -m'
alias gma='git commit -am'
alias gcb='git branch'
alias gchb='git checkout -b'
alias gch='git checkout'
alias gchm='git checkout master'
alias gchd='git checkout develop'
alias ga='git add'
alias gra='git remote add'
alias ggpush='git push'
alias ggpushf='git push --force-with-lease'
alias ggpull='git pull'
alias gst='git stash'
alias gstp='git stash pop'
# DOTT spécifique
alias gred='git rebase develop'
alias greod='git rebase origin develop'

# ── Alias — Docker / Kubectl ─────────────────────────────
alias dps='docker ps'
alias di='docker images'
alias drm='docker rm'
alias dlogs='docker logs -f'

# ── Alias — scripts DOTT ─────────────────────────────────
alias bump='~/workspace/kering/script/bump.sh'
alias add_gha_dott='~/workspace/kering/script/add_github_action_1.sh'
alias add_gha_cg='~/workspace/kering/script/add_github_action_CG.sh'
alias initp='~/workspace/kering/script/initDottProject.sh'
alias addbump='cp ~/workspace/kering/dott/sandbox/bump.sh ./dev'

# ── Alias — Zscaler (poste pro uniquement) ───────────────
alias zscaler-lock="sudo chmod -x /opt/zscaler/bin/zsupdater && echo \"✅ Zscaler update bloqué\""
alias zscaler-unlock="sudo chmod +x /opt/zscaler/bin/zsupdater && echo \"🔓 Zscaler update débloqué\""
alias zscaler-status="ls -la /opt/zscaler/bin/zsupdater && grep zscaler /etc/hosts"
alias zscaler-install="cd /home/fcrignon@niji.fr/Downloads && sudo ./Zscaler-linux-4.2.1.113-installer.run"
