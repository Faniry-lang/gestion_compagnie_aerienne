\c postgres;

DROP DATABASE IF EXISTS gestion_compagnie_aerienne;
CREATE DATABASE gestion_compagnie_aerienne;

\c gestion_compagnie_aerienne;

CREATE TABLE aeroport (
    id SERIAL PRIMARY KEY,
    code_iata VARCHAR(5) UNIQUE NOT NULL,
    nom VARCHAR(100) NOT NULL,
    ville VARCHAR(100),
    pays VARCHAR(100)
);

CREATE TABLE statut_avion (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE type_avion (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE avion (
    id SERIAL PRIMARY KEY,
    id_type_avion INT REFERENCES type_avion(id),
    modele VARCHAR(100),
    nbr_siege INT,
    constructeur VARCHAR(100),
    date_mise_service DATE
);

CREATE TABLE historique_statut_avion (
    id SERIAL PRIMARY KEY,
    id_avion INT NOT NULL REFERENCES avion(id),
    id_statut_avion INT NOT NULL REFERENCES statut_avion(id),
    created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE classe_siege (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE siege (
    id SERIAL PRIMARY KEY,
    id_avion INT NOT NULL REFERENCES avion(id),
    numero_siege VARCHAR(5), 
    id_classe_siege INT NOT NULL REFERENCES classe_siege(id)
);

CREATE TABLE itineraire (
    id SERIAL PRIMARY KEY,
    id_aeroport_depart INT NOT NULL REFERENCES aeroport(id),
    id_aeroport_arrivee INT NOT NULL REFERENCES aeroport(id),
    distance_km DOUBLE PRECISION,
    duree_moyenne_estimee INT -- en heure ty
);

CREATE TABLE statut_vol (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE statut_vol_avion (
  id SERIAL PRIMARY KEY,
  libelle VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE vol (
    id SERIAL PRIMARY KEY,
    numero_vol VARCHAR(10),
    id_aeroport_depart INT NOT NULL REFERENCES aeroport(id),
    id_aeroport_arrivee INT NOT NULL REFERENCES  aeroport(id),
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE vol_avion (
    id SERIAL PRIMARY KEY,
    id_vol INT NOT NULL REFERENCES vol(id),
    id_avion INT NOT NULL REFERENCES avion(id),
    date_depart TIMESTAMP NOT NULL,
    date_arrivee TIMESTAMP NOT NULL,
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE escale (
    id SERIAL PRIMARY KEY,
    id_vol_avion INT NOT NULL REFERENCES vol_avion(id),
    ordre INT NOT NULL,
    id_itineraire INT NOT NULL REFERENCES itineraire(id)
);

CREATE TABLE historique_statut_vol (
    id SERIAL PRIMARY KEY,
    id_vol INT NOT NULL REFERENCES vol(id),
    id_statut_vol INT NOT NULL REFERENCES statut_vol(id),
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE historique_statut_vol_avion (
   id SERIAL PRIMARY KEY,
   id_vol_avion INT NOT NULL REFERENCES vol_avion(id),
   id_statut_vol INT NOT NULL REFERENCES statut_vol(id),
   created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE passager (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    date_naissance DATE,
    nationalite VARCHAR(50),
    numero_passeport VARCHAR(50) UNIQUE,
    email VARCHAR(150),
    telephone VARCHAR(30)
);

CREATE TABLE statut_reservation (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE reservation (
    id SERIAL PRIMARY KEY,
    reference VARCHAR(20) UNIQUE NOT NULL,
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE historique_statut_reservation (
    id SERIAL PRIMARY KEY,
    id_reservation INT NOT NULL REFERENCES reservation(id),
    id_statut_reservation INT NOT NULL REFERENCES statut_reservation(id),
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE limite_bagage (
    id SERIAL PRIMARY KEY,
    volume_max DOUBLE PRECISION,
    poids_max DOUBLE PRECISION,
    pieces_max INT
);

CREATE TABLE forfait_bagage (
    id SERIAL PRIMARY KEY,
    nom_forfait VARCHAR(50) NOT NULL,
    poids_min DOUBLE PRECISION,
    poids_max DOUBLE PRECISION,
    volume_total DOUBLE PRECISION,
    nbr_piece INT,
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE taxe_aeroport (
    id SERIAL PRIMARY KEY,
    id_aeroport INT REFERENCES aeroport(id),
    montant DOUBLE PRECISION
);

CREATE TABLE tarif_vol (
    id SERIAL PRIMARY KEY ,
    id_vol INT NOT NULL REFERENCES vol(id),
    id_classe_siege INT REFERENCES classe_siege(id),
    montant DOUBLE PRECISION,
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE reservation_passager (
    id SERIAL PRIMARY KEY,
    id_reservation INT NOT NULL REFERENCES reservation(id),
    id_passager INT NOT NULL REFERENCES passager(id),
    id_vol INT REFERENCES vol(id),
    id_vol_avion INT NOT NULL REFERENCES  vol_avion(id),
    id_siege INT NOT NULL REFERENCES siege(id),
    prix DOUBLE PRECISION,
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE historique_statut_reservation_passager (
    id SERIAL PRIMARY KEY,
    id_reservation_passager INT NOT NULL REFERENCES reservation_passager(id),
    id_statut_reservation INT NOT NULL REFERENCES statut_reservation(id),
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE bagage_passager (
    id SERIAL PRIMARY KEY,
    id_reservation_passager INT NOT NULL REFERENCES reservation_passager(id),
    numero_bagage VARCHAR(10), 
    poids DOUBLE PRECISION,
    longueur DOUBLE PRECISION,
    largeur DOUBLE PRECISION,
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE statut_billet (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE billet (
    id SERIAL PRIMARY KEY,
    id_passager INT NOT NULL REFERENCES passager(id),
    id_vol INT REFERENCES vol(id),
    id_vol_avion INT NOT NULL REFERENCES vol_avion(id),
    id_siege INT NOT NULL REFERENCES siege(id),
    prix DOUBLE PRECISION NOT NULL,
    id_classe_siege INT NOT NULL REFERENCES classe_siege(id),
    id_reservation_passager INT REFERENCES reservation_passager(id) 
);

CREATE TABLE historique_statut_billet (
    id SERIAL PRIMARY KEY,
    id_billet INT NOT NULL REFERENCES billet(id),
    id_statut_billet INT NOT NULL REFERENCES statut_billet(id),
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE VIEW vol_details AS
SELECT
    v.id as id_vol,
    v.numero_vol,
    v.id_aeroport_depart,
    v.id_aeroport_arrivee,
    v.created_on as date_vol,
    va.id as id_vol_avion,
    va.date_depart,
    va.date_arrivee,
    va.created_on as date_vol_avion,
    a.id as id_avion,
    a.modele as modele_avion,
    a.nbr_siege as capacite_totale,
    COALESCE(vr.places_reservees, 0) as places_reservees,
    a.nbr_siege - COALESCE(vr.places_reservees, 0) as places_restantes
FROM vol_avion va
         JOIN vol v ON v.id = va.id_vol
         JOIN avion a ON a.id = va.id_avion
         LEFT JOIN (
    SELECT
        id_vol_avion,
        COUNT(*) as places_reservees
    FROM billet
    GROUP BY id_vol_avion
) as vr ON vr.id_vol_avion = va.id
ORDER BY va.created_on DESC;

CREATE OR REPLACE VIEW reservation_details AS
SELECT r.id, r.reference, r.created_on, COUNT(rp.id) AS nbr_passagers, SUM(rp.prix) AS montant_total
FROM reservation r
         JOIN reservation_passager rp ON rp.id_reservation = r.id
GROUP BY r.id, r.reference, r.created_on;

CREATE OR REPLACE VIEW v_avion_siege AS
SELECT
    a.id AS id_avion, a.modele AS avion_modele, COUNT(*) as nbr_siege, cs.id AS id_classe_siege, cs.libelle as classe_siege_libelle
FROM avion a JOIN siege s
                  ON a.id = s.id_avion
             JOIN classe_siege cs
                  ON s.id_classe_siege = cs.id
GROUP BY a.id, a.modele, cs.id, cs.libelle;

CREATE TABLE tranche_age (
    id SERIAL PRIMARY KEY ,
    age_min INT,
    age_max INT,
    libelle VARCHAR(20)
);

CREATE TABLE remise_age_tarif (
    id SERIAL PRIMARY KEY,
    id_vol INT NOT NULL REFERENCES  vol(id),
    id_classe_siege INT NOT NULL REFERENCES classe_siege(id),
    id_tranche_age INT NOT NULL REFERENCES tranche_age(id),
    montant_pourcentage DOUBLE PRECISION,
    montant_complet DOUBLE PRECISION,
    est_en_pourcentage BOOLEAN,
    id_tranche_age_ref INT REFERENCES tranche_age(id),
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--ALTER TABLE remise_age_tarif ADD COLUMN id_tranche_age_ref INT REFERENCES tranche_age(id);
ALTER TABLE remise_age_tarif ALTER COLUMN id_classe_siege DROP NOT NULL;

CREATE TABLE societe(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE cout_pub(
    id SERIAL PRIMARY KEY,
    montant DOUBLE PRECISION
);

CREATE TABLE diffusion_pub(
    id SERIAL PRIMARY KEY,
    id_societe INT REFERENCES societe(id),
    mois INT,
    annee INT,
    nbr_diffusion INT
);