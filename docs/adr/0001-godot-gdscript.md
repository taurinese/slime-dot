# ADR-0001 : Godot 4 + GDScript

- **Statut** : accepté
- **Date** : 2026-10-07

## Contexte

Premier jeu vidéo : 2D pixel art, incrémental/idle, ciblant PC (Windows, Linux, Steam Deck) et le web (preview jouable, itch.io). Le développeur vient de JavaScript, lit le Python, et veut apprendre en comprenant chaque ligne. Le projet est solo, avec des assets gratuits.

## Décision

- Moteur **Godot 4**, **version standard** (sans .NET), épinglée à **4.7.2-stable** en local et en CI.
- Langage **GDScript** avec **typage statique systématique** : les warnings de typage sont traités comme des erreurs.
- Moteur de rendu **Compatibility** (OpenGL ES 3 / WebGL 2).

## Alternatives considérées

- **Godot + C# (.NET)** : langage plus outillé, mais pas d'export web en Godot 4, des builds plus lourds, et une boucle d'itération plus lente. Le C# n'apporte rien d'indispensable pour ce jeu.
- **Unity** : écosystème riche, mais lourd pour de la 2D simple, avec une licence et un historique de changements tarifaires peu rassurants. Il impose le C#.
- **Framework web (Phaser, PixiJS)** : langage familier, mais sans éditeur de scènes, de tilemaps ni d'animations intégré. L'export bureau/Steam passerait par Electron ou un équivalent.
- **Moteur de rendu Forward+ / Mobile** : inutiles pour de la 2D, et incompatibles avec l'export web.

## Conséquences

- ➕ Un éditeur complet pour la 2D (TileMap, animations, collisions), léger et open source (MIT, sans royalties).
- ➕ GDScript ressemble au Python, s'apprend vite et est intégré à l'éditeur. Le typage strict apporte la sécurité de TypeScript « strict » et de meilleures performances.
- ➕ Un même projet s'exporte vers Windows, Linux et le web.
- ➖ GDScript est moins outillé que TS ou C# (refactoring, écosystème de bibliothèques). On le compense avec gdtoolkit (lint/format) et GUT (tests).
- ➖ Le rendu Compatibility n'offre pas certains effets avancés, sans impact pour du pixel art.
- ⚠️ Toute montée de version de Godot se fait dans une PR dédiée (README + CI).
