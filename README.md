# terminal_configs

Configuration personnelle de terminal (dotfiles) : fish, starship et
Ghostty.

## Structure

- `configs/fish/personal/config.fish` — machine perso (Bazzite/Homebrew)
- `configs/fish/work/` — poste pro DOTT/kering (Debian/Ubuntu) : `config.fish`,
  `functions/` (fonctions perso), `fish_plugins` (liste fisher)
- `configs/starship/starship_cyber_2.toml` — thème actif sur la machine perso
- `configs/starship/starship_work.toml` — thème actif sur le poste pro
- `configs/starship/starship.toml`, `starship_cyber.toml` — thèmes alternatifs
- `configs/ghostty/config` — config Ghostty active sur la machine perso
  (thème cyberpunk_neon assorti à `starship_cyber_2.toml`, police Hack Nerd
  Font Mono). À copier/symlinker vers `~/.config/ghostty/config`.

Pas de scripts d'installation ici : cette logique vit dans
[`scripts_library`](https://github.com/fcrignon/scripts_library) (voir
`CLAUDE.md`).

## Installation

Ce dépôt ne contient que des fichiers de config. L'installation (fish,
starship, liaison des fichiers) passe par `scripts_library` :

```sh
# machine perso
fish-starship-setup --repo git@github.com:fcrignon/terminal_configs.git \
  --fish-path configs/fish/personal \
  --starship-path configs/starship/starship_cyber_2.toml

# poste pro (installer ensuite fisher, puis `fisher update` pour nvm.fish/bass)
fish-starship-setup --repo git@github.com:fcrignon/terminal_configs.git \
  --fish-path configs/fish/work \
  --starship-path configs/starship/starship_work.toml
```

Voir `CLAUDE.md` pour le détail de la relation entre les deux dépôts.
