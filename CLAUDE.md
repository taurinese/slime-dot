# CLAUDE.md — slime-dot

Mémoire du projet pour Claude. À lire en début de session, avec `docs/ROADMAP.md` (où on en est).

## Le projet

- Premier jeu vidéo d'Enzo (dév JS, lit le Python, débutant en jeu vidéo). Double objectif : un jeu de qualité **et** apprendre à le faire seul.
- Jeu 2D pixel art (tuiles 16×16), inspiré de Forage Wizard : récolte (minerais, plantes, arbres…), craft, construction.
- Le joueur est un **slime** qui se déplace dans le monde (pas de récolte au curseur).
- Cœur du jeu : **incrémental/idle** avec une **automatisation efficace et intuitive** (peu chère, peu de micro-gestion, pas de récolte manuelle sans fin).
- Histoire minimale. Assets gratuits (Kenney, Ninja Adventure…), chaque asset et sa licence tracés dans `assets/CREDITS.md`.
- Cible : PC (Windows/Linux, Steam Deck), itch.io puis Steam.

## Décisions techniques

- **Godot 4.7.2-stable, version standard (pas .NET/Mono)** + GDScript. Même version en local et en CI, notée dans le README.
- Moteur de rendu **Compatibility** (2D + export web).
- **Typage statique systématique** ; warnings de typage = erreurs (paramètres du projet).
- Tests : **GUT**, exécuté en headless.
- Qualité : **gdtoolkit** (`gdlint`, `gdformat`) + hooks **pre-commit**.
- Git : trunk-based (`main` toujours jouable), branches `feat/...` / `fix/...`, PR, **Conventional Commits**.
- CI/CD : GitHub Actions — lint + tests sur chaque PR ; export Windows/Linux/Web ; releases sur tag. Homelab plus tard (preview web, runner CI) : **demander à Enzo comment il est configuré le moment venu**.
- Docs : README, ADR courts dans `docs/adr/` (contexte, décision, alternatives, conséquences), game design dans `docs/design/`, commentaires `##` dans le code.

## Architecture : simulation séparée de l'affichage

Toute la logique de jeu (ressources, inventaires, recettes, machines, flux, progression) vit dans `src/simulation/` :
- ne dépend de **rien de visuel** (pas de nœuds de scène, pas de sprites) ;
- avance par **ticks** réguliers, **déterministe**, testable unitairement ;
- **pilotée par les données** : ressources, recettes, machines = Resources Godot (`.tres`) dans `src/data/` ;
- permet de calculer la **progression hors-ligne**.

L'affichage (`src/world/`, `src/player/`, `src/ui/`) observe la simulation (signaux) et lui envoie des commandes.

Arborescence cible : `.github/workflows/` · `addons/` · `assets/` · `docs/adr/` · `docs/design/` · `src/simulation/` · `src/data/` · `src/world/` · `src/player/` · `src/ui/` · `tests/` · `CLAUDE.md` · `README.md` · `project.godot`

## Environnement (PC Windows 11)

- Projet : `%USERPROFILE%\dev\slime-dot` (disque local, hors OneDrive, **jamais dans WSL**).
- Outils natifs Windows, installations via `winget`. WSL seulement si un outil l'exige vraiment, après explication.
- Code dans **Cursor** (extension `geequlim.godot-tools`), scènes dans l'**éditeur Godot**. Cursor = éditeur externe de Godot.
- Godot (winget, alias PATH `Godot_v4.7.2-stable_win64.exe` / `Godot_v4.7.2-stable_win64_console.exe`) :
  `%LOCALAPPDATA%\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\`
  Utiliser la variante `_console.exe` pour la ligne de commande (headless, tests, exports).
- Fins de ligne : `.gitattributes` avec `* text=auto eol=lf` ; `core.autocrlf=false` dans `~/.gitconfig` (la config système de Git for Windows met `true`). La CI tourne sous Linux.
- Versions : Git 2.53, Python 3.13, Cursor 3.23, GitHub CLI 2.102.
- Après avoir modifié des fichiers : **rappeler à Enzo de revenir sur la fenêtre Godot** pour qu'il les détecte.

## Commandes utiles

_(à compléter au fur et à mesure : tests, lint, format, export…)_

## Règles de travail

1. **Petites étapes** : un objectif clair et vérifiable ; expliquer quoi et pourquoi, puis **attendre la validation**.
2. **Expliquer en codant** : concepts Godot/GDScript de chaque fichier, avec comparaisons JS quand utile.
3. **Faire pratiquer** : exercices réguliers avec indices, puis review exigeante mais bienveillante.
4. **L'éditeur Godot, c'est Enzo** : scènes, tuiles, collisions, animations → le guider pas à pas. Ne modifier un `.tscn` qu'avec son accord explicite.
5. **Demander avant** d'installer, de modifier une config système, une commande destructive ou un push.
6. **Tests d'abord** pour `src/simulation/`.
7. **Pas de sur-ingénierie** ; le signaler si Enzo pousse dans cette direction.
8. **Honnêteté** : dire quand une idée pose problème, et pourquoi.
9. Tenir `docs/ROADMAP.md` à jour (étapes cochées + ce qu'on a appris).
