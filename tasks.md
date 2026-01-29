Nouvelle fonctionalité:
    -faire ressortir le chiffre d'affaire global du mois de janvier 2026 pour: billet, pub et produits extra
    -voici les nouvelles tables:
        ``` 
            CREATE TABLE produit_extra (
                id SERIAL PRIMARY KEY ,
                descr TEXT
            );

            CREATE TABLE prix_vente_produit (
                id SERIAL PRIMARY KEY,
                id_produit_extra INT REFERENCES produit_extra(id),
                montant DOUBLE PRECISION,
                date_mis_a_jour TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
            );

            CREATE TABLE vente_produit (
                id SERIAL PRIMARY KEY,
                id_produit_extra INT REFERENCES produit_extra(id),
                qte INT,
                prix_unitaire_du_jour DOUBLE PRECISION,
                id_vol_avion INT REFERENCES vol_avion(id),
                date_vente TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
            );
        ```
    -on doit créer un Servlet CAGlobalServlet pour exposer la page ca-global.jsp affichant dans un tableau les champs suivant:
        -CA par vente de billet
        -CA par diffusion de pub
        -CA par vente de produit_extra
    -Créer un DTO CAGlobal avec les champs suivant:
        -caBillet
        -caPub
        -caProduitExtra
        -date (mois et année)
    -la page ca-global.jsp doit avoir un filtre par volAvion et date (mois et année)
    -dans tous-vols-ca.jsp, ajouter également une colonne CA extra et modifier CAGlobalParVolAvion pour ajouter le champ caExtra