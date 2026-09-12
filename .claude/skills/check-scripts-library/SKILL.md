---
name: check-scripts-library
description: Use before adding any install/setup script (or significant shell logic) to terminal_configs, or when asked whether some functionality belongs in terminal_configs or in the sibling scripts_library repo, or whether the two repos should be merged. Checks for overlap with scripts_library and routes new logic to the right repo.
---

# Coordonner terminal_configs et scripts_library

`terminal_configs` (ce dépôt) contient des **fichiers de config** (fish,
starship). `scripts_library` (`../scripts_library`, dépôt frère, remote
GitHub séparé) contient la **logique d'installation/setup réutilisable**.
Voir `CLAUDE.md` de ce dépôt pour le détail de cette séparation.

Ne pas fusionner les deux dépôts : `scripts_library` est une bibliothèque
générique, sans données personnelles, versionnée indépendamment (tags,
CHANGELOG) ; `terminal_configs` contient des alias et des chemins propres à
l'utilisateur (ex: `fish_work.fish`). Les mélanger romprait la possibilité
de cloner l'un sans l'autre et polluerait `scripts_library` avec des
données personnelles. Si l'utilisateur redemande explicitement une fusion,
proposer plutôt un dépôt "meta" léger (README + script de bootstrap qui
clone les deux) plutôt qu'une fusion d'historique.

## Avant d'ajouter un script ici

1. Lire `../scripts_library/README.md` (section "Scripts disponibles") pour
   voir si une fonctionnalité équivalente existe déjà.
2. Si oui : ne pas dupliquer. Utiliser/documenter le script de
   `scripts_library` depuis ce dépôt (voir `CLAUDE.md`, section "Relation
   avec scripts_library" pour l'exemple `fish-starship-setup.sh --repo`).
3. Si non, mais que la fonctionnalité est générique (pas spécifique aux
   données de ce dépôt — ex: "installer tel outil", "configurer telle
   intégration système") : elle appartient à `scripts_library`, pas ici.
   Basculer dans ce dépôt et suivre son propre skill `add-script` (plan,
   écriture, tests, doc README, changelog, `/code-review`, branche + PR —
   jamais de commit direct sur `main`).
4. Un script n'a sa place dans `terminal_configs/scripts/` que s'il est
   intrinsèquement lié aux fichiers de config de ce dépôt et ne fait pas de
   sens ailleurs (rare — dans le doute, il va dans `scripts_library`).

## Historique : scripts legacy retirés (2026-09-12)

`terminal_configs/scripts/` contenait des scripts antérieurs à
`scripts_library` qui faisaient doublon avec des versions plus robustes.
Ils ont été supprimés et leur logique migrée :

| Retiré d'ici | Remplacé par (scripts_library) |
| --- | --- |
| `install_starship.sh`, `set_fish_as_default.sh` | `linux/install/fish-starship-setup.sh` (dry-run, sauvegarde de config, gestion du `chsh`) |
| `install-app.sh` (zoxide/bat/fish/eza/lazygit/lazydocker/starship/rustscan/jq) | `linux/install/term-tools-install.sh` (catalogue, `jq`/`rustscan` ajoutés) |
| `install_nerd_font.sh` / `install_nerd_font_server.sh` | `linux/install/nerd-fonts-install.sh` (un seul script, `--system`/`--user`) |

Si un nouveau besoin de ce type apparaît, ne pas recréer de script ici :
suivre le processus décrit ci-dessus (§ "Avant d'ajouter un script ici").
Demander confirmation à l'utilisateur avant de supprimer des scripts ou
d'ouvrir une PR sur `scripts_library` — ce sont des actions sur un autre
dépôt avec son propre remote.
