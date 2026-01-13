# Gestion Compagnie Aérienne

---

## 1. Vue d'ensemble

Application Java web (JSP/Servlet) qui gère une compagnie aérienne : vols, avions, itinéraires, réservations, billets, etc. Le projet utilise Maven et un ORM "maison" nommé `Legacy` (présent dans le code via `legacy.*`), des JSP côté serveur, et des servlets pour la logique métier.

---

## 2. Structure principale (arborescence simplifiée)

Voici une vue schématique (dossiers seulement, niveaux pertinents) :

```
/ (racine)
├─ pom.xml
├─ package.json
├─ src/
│  ├─ main/
│  │  ├─ java/
│  │  │  └─ gestion_compagnie_aerienne/
│  │  │     ├─ code_generator/       # utilitaires de génération de code / templates
│  │  │     ├─ entities/             # entités métier (ORM Legacy)
│  │  │     └─ servlet/              # servlets (contrôleurs)
│  │  ├─ resources/
│  │  │  └─ templates/               # templates utilisés par le générateur
│  │  └─ webapp/
│  │     ├─ pages/                   # JSP organisés par entité (vol, reservation, billet...)
│  │     ├─ assets/                  # css, icons, images
│  │     └─ WEB-INF/
│  │        └─ web.xml
├─ sql/                             # scripts SQL (schema, data, requêtes)
└─ target/                          # build output
```

> Nota : le dépôt contient d'autres dossiers (target, classes générées, etc.). Ci‑dessus la structure pertinente pour la compréhension.


## 3. Contenu des packages Java (dossiers)

- `gestion_compagnie_aerienne/code_generator/`
    - Générateurs de code / templates (JSP/Servlet) — utilitaires pour produire pages CRUD à partir des entités.

- `gestion_compagnie_aerienne/entities/`
    - Définitions des classes entités (annotées avec `legacy.annotations`) mappées aux tables.
    - Contient aussi les classes de statut/historique (ex. `StatutVol`, `HistoriqueStatutVol`, ...).

- `gestion_compagnie_aerienne/servlet/`
    - Servlets gérant les opérations HTTP (list, form, create, update, details) pour chaque entité.

Remarque : la structure des JSP est dans `src/main/webapp/pages/` (sous-dossiers par entité : `vol`, `reservation`, `billet`, `avion`, `aeroport`, `itineraire`, ...).

---

## 4. Stack technique

- Langage : Java (servlets/JSP)
- Serveur web : conteneur servlet (ex. Tomcat) — utilisation de servlets Jakarta (pakage `jakarta.servlet.*`).
- Build : Maven (`pom.xml`).
- Views : JSP + assets CSS / icônes.
- ORM : `Legacy` (ORM homemade, packages `legacy.*`) — le projet utilise ce framework interne pour findAll / filter / save / mount.
- DB : relationnelle (scripts SQL fournis dans le dossier `sql/`).

---

## 5. Fonctionnalités principales

- CRUD pour les entités principales : Vol, VolAvion (occurrences), Avion, Aeroport, Itineraire, Reservation, Billet, Passager, etc.
- Listes avec filtres (side panel ou champs au-dessus du tableau), recherches textuelles, et filtres numériques/dates.
- Modals / popups pour la création rapide d'enregistrements (ex. créer un avion, créer une occurrence de vol).
- Générateur de code (templates) pour produire JSP/Servlet à partir du modèle d'entités.
- Gestion (pré‑existante) de plusieurs entités de statut et historiques (tables `statut_*` et `historique_statut_*`).

---

