# ADR-0002 : Simulation séparée de l'affichage

- **Statut** : accepté
- **Date** : 2026-10-07

## Contexte

Le cœur du jeu est l'automatisation : des machines qui produisent, transforment et transportent des ressources, et une progression qui continue hors-ligne. Cette logique sera la partie la plus complexe et la plus sujette aux bugs. Il faut pouvoir la tester sans lancer le jeu, la faire avancer de N heures d'un coup au retour du joueur, et équilibrer les chiffres sans toucher au code.

## Décision

Toute la logique de jeu vit dans `src/simulation/` et respecte ces règles :

1. **Aucune dépendance visuelle** : pas de nœuds de scène, de sprites ni de `get_tree()`. Le code est fait de classes GDScript simples (`RefCounted`/`Resource`).
2. **Avancée par ticks** à pas fixe, indépendante du framerate.
3. **Déterministe** : même état et mêmes commandes donnent le même résultat. L'aléatoire passe par une graine contrôlée.
4. **Pilotée par les données** : ressources, recettes et machines sont des Resources Godot (`.tres`) dans `src/data/`.

L'affichage (`src/world/`, `src/player/`, `src/ui/`) **observe** la simulation via des signaux et lui **envoie des commandes** (« récolter ici », « construire cette machine »). Il ne modifie jamais l'état directement.

## Alternatives considérées

- **Logique dans les nœuds de scène** (le style « Godot classique ») : plus rapide pour démarrer, mais la logique devient difficile à tester. La progression hors-ligne nécessiterait alors de rejouer la scène ou de dupliquer la logique.
- **ECS ou framework d'architecture** : trop lourd pour un premier jeu, ce serait de la sur-ingénierie à ce stade.

## Conséquences

- ➕ Tests unitaires rapides en headless (GUT), sans scène.
- ➕ Progression hors-ligne : on appelle `tick()` N fois, ou un calcul analytique plus tard si c'est trop lent.
- ➕ Sauvegarde simple : on ne sérialise que l'état de la simulation.
- ➕ Équilibrage via les `.tres`, sans toucher au code.
- ➖ Plus de code de liaison entre simulation et affichage (signaux, commandes).
- ➖ Il faut de la discipline : la tentation de « juste lire la position d'un sprite » dans la simulation sera là. À surveiller en review.
- 📌 Analogie web : la simulation est le *store* (Redux, Zustand), l'affichage les composants qui s'y abonnent et dispatchent des actions.
