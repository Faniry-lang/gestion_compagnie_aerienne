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
    prix_total DOUBLE PRECISION,
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
