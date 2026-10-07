# Roadmap

Étapes cochées au fur et à mesure, avec ce qu'on a appris à chacune.

## Étape 0 — Setup

- [x] Inventaire de l'environnement Windows
- [x] Installer/configurer ce qui manque (Godot 4.7.2 standard, GitHub CLI, godot-tools, config Git)
- [x] `CLAUDE.md` + `docs/ROADMAP.md`
- [x] Créer le projet Godot (rendu Compatibility, typage strict) + connecter Cursor (éditeur externe, LSP)
- [x] `git init`, `.gitignore` Godot, `.gitattributes`, arborescence
- [x] `README.md`, ADR-0001 « Godot + GDScript », ADR-0002 « Simulation séparée de l'affichage »
- [x] gdtoolkit + pre-commit
- [ ] GUT + un premier test lancé en headless
- [ ] Dépôt GitHub + workflow GitHub Actions lint + tests

**Appris :**
- Toujours vérifier la version stable (API des releases GitHub de Godot) plutôt que la supposer → 4.7.2-stable (18/08/2026).
- La version **Mono/.NET** de Godot était installée par défaut : à éviter pour nous (C# inutile, et pas d'export web en Godot 4 .NET). Remplacée par la version standard.
- Git for Windows active `core.autocrlf=true` au niveau système : on le surcharge à `false` dans `~/.gitconfig`, et `.gitattributes` imposera `eol=lf`. Vérification : `git ls-files --eol`.
- Le Project Manager de Godot coche « Create Folder » par défaut → projet créé dans un sous-dossier. `project.godot` doit être à la racine du dépôt.
- Typage strict = Project Settings → Advanced → Debug → GDScript, warnings passés à Error (stockés dans `project.godot`, section `[debug]`, valeur `2`). « Exclude Addons » reste actif (défaut) pour ne pas casser sur GUT.
- Le LSP GDScript tourne dans l'éditeur Godot (port 6005) : autocomplétion dans Cursor seulement si Godot est ouvert.
- pre-commit ≈ Husky + lint-staged ; gdformat ≈ Prettier, gdlint ≈ ESLint. pre-commit installe ses hooks dans son propre environnement isolé (téléchargé depuis GitHub) → aligner manuellement la version de gdtoolkit (4.5.0) entre local, `.pre-commit-config.yaml` et CI. gdtoolkit 4.x = syntaxe Godot 4.
- Git ne versionne pas les dossiers vides → fichiers `.gitkeep`. `.vscode/` est ignoré (chemins propres à la machine).

## Étape 1 — « Hello slime »

- [ ] Slime placeholder qui se déplace sur une carte en tuiles, caméra pixel perfect

## Étape 2 — Récolte + inventaire

- [ ] Premier vrai code de `src/simulation/`, avec tests

## Étape 3 — Craft et construction

## Étape 4 — Moteur d'automatisation

- [ ] Session de game design avant de coder

## Étape 5 — Sauvegarde + progression hors-ligne

## Étape 6 — Export, preview web sur le homelab, releases
