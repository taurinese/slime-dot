# slime-dot

Jeu 2D en pixel art, incrémental/idle, où l'on incarne un slime qui récolte, crafte et construit, avec une **automatisation efficace et intuitive** comme cœur du jeu.

> 🚧 En tout début de développement. Voir [docs/ROADMAP.md](docs/ROADMAP.md).

## Prérequis

| Outil | Version | Installation (Windows) |
|---|---|---|
| Godot (standard, **pas** .NET) | **4.7.2-stable** | `winget install --id GodotEngine.GodotEngine --version 4.7.2 --exact` |
| Git | 2.53+ | `winget install --id Git.Git` |

La version de Godot est **épinglée** : la même en local et en CI. Toute montée de version passe par une PR dédiée qui met à jour ce README et la CI.

### Configuration Git

Le dépôt impose des fins de ligne LF (`.gitattributes`). Sous Windows, désactiver la conversion automatique :

```bash
git config --global core.autocrlf false
```

## Lancer le jeu

Ouvrir `project.godot` avec Godot 4.7.2 (Project Manager → **Import**), puis **F5**.

## Organisation du dépôt

| Dossier | Contenu |
|---|---|
| `src/simulation/` | Logique de jeu pure : ticks, déterministe, sans rien de visuel (voir [ADR-0002](docs/adr/0002-simulation-separee-affichage.md)) |
| `src/data/` | Définitions de données (`.tres`) : ressources, recettes, machines |
| `src/world/`, `src/player/`, `src/ui/` | Affichage : observe la simulation et lui envoie des commandes |
| `tests/` | Tests GUT |
| `assets/` | Assets graphiques et sonores (crédits et licences dans `assets/CREDITS.md`) |
| `addons/` | Plugins Godot tiers |
| `docs/adr/` | Décisions d'architecture |
| `docs/design/` | Game design |

## Documentation

- [Roadmap](docs/ROADMAP.md)
- [Décisions d'architecture (ADR)](docs/adr/)
