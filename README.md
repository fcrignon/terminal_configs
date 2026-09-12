# terminal_configs

Configuration personnelle de terminal (dotfiles) : fish et starship.

## Structure

- `configs/fish/config.fish` — config fish par défaut
- `configs/fish/fish_work.fish` — variante avec alias spécifiques au poste pro
- `configs/starship/starship.toml` — thème starship actif (xcad)
- `configs/starship/starship_cyber*.toml` — thèmes alternatifs

Pas de scripts d'installation ici : cette logique vit dans
[`scripts_library`](https://github.com/fcrignon/scripts_library) (voir
`CLAUDE.md`).

## Installation

Ce dépôt ne contient que des fichiers de config. L'installation (fish,
starship, liaison des fichiers) passe par `scripts_library` :

```sh
fish-starship-setup --repo git@github.com:fcrignon/terminal_configs.git \
  --fish-path configs/fish/config.fish \
  --starship-path configs/starship/starship.toml
```

Voir `CLAUDE.md` pour le détail de la relation entre les deux dépôts.
