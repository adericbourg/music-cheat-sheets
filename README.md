# Fiches pratiques pour la musique

Ce dépôt rassemble des fiches d'aide pour le groupe. Chaque fiche vit dans son propre dossier, sous forme de source LaTeX.

Les PDF ne sont pas versionnés : ils sont compilés par GitHub Actions et publiés dans la release [Latest versions](https://github.com/adericbourg/music-cheat-sheets/releases/tag/latest), qui contient toujours la version la plus récente de chaque fiche.

## Fiches

| Fiche | Contenu | PDF | Source |
|---|---|---|---|
| Réglages de départ pour les balances | Réglages d'égalisation, de compression et de reverb par source sur une Zoom LiveTrak L-20, conseils de balance, aide-mémoire des registres | [balances.pdf](https://github.com/adericbourg/music-cheat-sheets/releases/download/latest/balances.pdf) | [`balances/`](balances/) |
| Place des instruments dans le spectre | Plage totale, zone utile, zone à couper et zones à surveiller de chaque instrument du groupe, sur l'axe des registres | [spectre.pdf](https://github.com/adericbourg/music-cheat-sheets/releases/download/latest/spectre.pdf) | [`spectre/`](spectre/) |

## Fonctionnement

- Une fiche est un dossier à la racine qui contient un fichier de même nom : `<dossier>/<dossier>.tex`. Le PDF publié s'appelle `<dossier>.pdf`.
- Sur une pull request, l'action compile les fiches modifiées et joint les PDF à l'exécution, pour les relire avant de fusionner.
- Après une fusion sur `main`, l'action recompile seulement les fiches modifiées et remplace leur PDF dans la release.
- L'action peut aussi être lancée à la main depuis l'onglet *Actions* (« Run workflow ») : elle recompile alors toutes les fiches.

## Ajouter une fiche

1. Créer le dossier `ma-fiche/` avec `ma-fiche/ma-fiche.tex`.
2. Ajouter une ligne au tableau ci-dessus, avec le lien `https://github.com/adericbourg/music-cheat-sheets/releases/download/latest/ma-fiche.pdf`.
3. Ouvrir une pull request.

Les fiches se compilent avec LuaLaTeX et utilisent la police [Inter](https://rsms.me/inter/). En local : `./build.sh` vérifie les prérequis et compile toutes les fiches (ou `./build.sh ma-fiche` pour une seule) ; les PDF sont écrits dans `output/`.
