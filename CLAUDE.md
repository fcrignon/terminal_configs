# terminal_configs

Dépôt de **configuration personnelle** de terminal (dotfiles) : fichiers de
config fish et starship. Ce dépôt ne contient **pas** de logique
d'installation générique — celle-ci vit dans le dépôt frère
[`scripts_library`](../scripts_library) (voir `## Relation avec scripts_library`
ci-dessous). `terminal_configs` fournit les *données* de config, `scripts_library`
fournit la *logique* qui les installe.

## Structure

```
terminal_configs/
└── configs/
    ├── fish/
    │   ├── config.fish       # config fish par défaut (perso)
    │   └── fish_work.fish    # variante avec alias spécifiques au poste pro
    └── starship/
        ├── starship.toml         # thème actif (xcad)
        ├── starship_cyber.toml   # thème alternatif
        └── starship_cyber_2.toml # thème alternatif
```

Ce dépôt ne contient volontairement **aucun script d'installation** : il n'y
a jamais eu que des doublons moins robustes de ce qui existe dans
`scripts_library` (voir `## Relation avec scripts_library`), et ils ont été
retirés (2026-09-12) au profit de `fish-starship-setup.sh` et
`term-tools-install.sh`. N'en recrée pas ici — toute logique d'installation
générique va dans `scripts_library`.

## Relation avec scripts_library

`scripts_library` (dépôt frère, `../scripts_library`) contient
`linux/install/fish-starship-setup.sh`, conçu précisément pour consommer un
dépôt de dotfiles comme celui-ci via `--repo` :

```sh
fish-starship-setup --repo git@github.com:fcrignon/terminal_configs.git \
  --fish-path configs/fish/config.fish \
  --starship-path configs/starship/starship.toml
```

Les chemins `--fish-path`/`--starship-path` sont **nécessaires** : la
détection automatique du script (`fish/`, `.config/fish/`, `config.fish`,
`starship.toml`, `.config/starship.toml`, `fish/starship.toml` à la racine du
repo) ne correspond pas à la structure `configs/fish/` et
`configs/starship/` de ce dépôt. Si un jour la structure ci-dessus change,
mettre à jour cette commande en conséquence (et inversement : si
`scripts_library` fait évoluer les motifs de détection automatique, vérifier
s'ils peuvent maintenant matcher `configs/` directement).

Règle générale pour toute session Claude travaillant sur ce dépôt :
- avant d'ajouter un script d'installation/setup ici, vérifier s'il a sa
  place dans `scripts_library` à la place (c'est presque toujours le cas —
  ce dépôt-ci n'a vocation qu'à contenir des fichiers de config, pas de la
  logique réutilisable) ;
- si une fonctionnalité existe en double dans les deux dépôts, la version de
  `scripts_library` est la version de référence (testée, avec `--dry-run`,
  gestion d'erreurs, etc.) ;
- toute modification dans `scripts_library` suit son propre processus (voir
  son `CLAUDE.md` et le skill `add-script`) : branche dédiée + PR, jamais de
  commit direct sur `main`.

## Conventions fish

- Gérer les changements d'état interactif (nvm, greeting) sous
  `if status is-interactive` pour ne pas casser les shells non interactifs
  (scripts, VS Code tasks, etc.)
- Ne jamais définir deux fois le même alias avec des valeurs différentes
  dans un même fichier (source d'incohérence silencieuse — seule la dernière
  définition gagne)
- Utiliser `$HOME` plutôt qu'un chemin utilisateur en dur (`/home/<user>/...`)
- Garder `type -q <cmd>; and ...` autour des initialisations d'outils
  externes (starship, zoxide, brew) pour que le shell reste utilisable même
  avant que l'outil soit installé
